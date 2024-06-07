page 99016 "ITI Migrations"
{
    ApplicationArea = All;
    Caption = 'Migrations';
    PageType = List;
    SourceTable = "ITI Migration";
    UsageCategory = Administration;
    DataCaptionFields = "Code", "Source SQL Database Code", "Target SQL Database Code";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code of the migration.';
                    ApplicationArea = All;
                }
                field(Executed; Rec.Executed)
                {
                    ToolTip = 'Specifies if the meigration queries were executed.';
                    ApplicationArea = All;
                }
                field("Generated Queries"; Rec."Generated Queries")
                {
                    ToolTip = 'Specifies if migration queries were generated.';
                    ApplicationArea = All;
                }
                field("Migration Dataset Code"; Rec."Migration Dataset Code")
                {
                    ToolTip = 'Specifies the ocde of the Migration Dataset.';
                    ApplicationArea = All;
                }
                field("Source SQL Database Code"; Rec."Source SQL Database Code")
                {
                    ToolTip = 'Specifies the code of the Source SQL Database.';
                    ApplicationArea = All;
                }
                field("Source Company Name"; Rec."Source Company Name")
                {
                    ToolTip = 'Specifies the name of the source Company.';
                    ApplicationArea = All;
                }
                field("Target SQL Database Code"; Rec."Target SQL Database Code")
                {
                    ToolTip = 'Specifies the code of the target SQL Database.';
                    ApplicationArea = All;
                }
                field("Target Company Name"; Rec."Target Company Name")
                {
                    ToolTip = 'Specifies the name of the target Company.';
                    ApplicationArea = All;
                }
                field("Execute On"; Rec."Execute On")
                {
                    ToolTip = 'Specifies the database, which will be the target of the generated queries.';
                    ApplicationArea = All;
                }
                field("Do Not Use Transaction"; Rec."Do Not Use Transaction")
                {
                    ToolTip = 'Specifies if every query should be executed as a single transaction.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Generate Queries")
            {
                ToolTip = 'Generate Queries';
                Image = ProductionSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.GenerateSQLQueries(false, '');
                end;
            }
            action("Execute")
            {
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Execute Migration';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec.RunMigration(false);
                end;
            }
            action("Execute In Background")
            {
                Image = AutoReserve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Execute all of this migrations queries in background.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    ITIRunLinkedServerQuery: Codeunit "ITI Run Linked Server Query";
                    ITIRunMigrSQLQueriesBG: Codeunit "ITI Run Migr SQL Queries BG";
                begin
                    ITIRunLinkedServerQuery.Run(Rec);
                    ITIRunMigrSQLQueriesBG.Run(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action("Queries")
            {
                ToolTip = 'Show migration SQL Queries';
                Image = Table;
                RunObject = Page "ITI Migration SQL Queries";
                RunPageLink = "Migration Code" = field("Code");
                RunPageMode = View;
                ApplicationArea = All;
            }
            action("Log Entries")
            {
                ToolTip = 'Show migration Log Entries';
                Image = InteractionLog;
                RunObject = Page "ITI Migration Log Entries";
                RunPageLink = "Migration Code" = field("Code");
                RunPageMode = View;
                ApplicationArea = All;
            }
            action("Edit Linked Server Query")
            {
                ToolTip = 'Edit SQL query which will link source database to the one marked as target.';
                Image = Edit;
                RunObject = Page "ITI Edit Linked Server Query";
                RunPageLink = Code = field("Code");
                RunPageMode = View;
                ApplicationArea = All;
            }

            action("Migration Background Sessions")
            {
                ToolTip = 'Show migration macground sessions';
                ApplicationArea = All;
                Image = CarryOutActionMessage;
                RunObject = Page "ITI Migr. Background Sessions";
                RunPageLink = "Migration Code" = field("Code");
                RunPageMode = View;
            }
        }
    }

}
