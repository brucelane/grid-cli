export interface ModuleFile {
  version?: string;
  created?: string;
  modified?: string;
  toolVersion?: string;
  index?: number;
  // Support both position array and dx/dy
  position?: [number, number];
  dx?: number;
  dy?: number;
  type: string;
  typeId?: number;
  firmware?: {
    major: number;
    minor: number;
    patch: number;
  };
  elements?: Array<{
    index: number;
    type: string;
  }>;
  pages?: number[];
}
