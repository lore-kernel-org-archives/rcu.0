Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1372BC43334
	for <rcu@archiver.kernel.org>; Thu,  2 Jun 2022 02:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbiFBCG7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Jun 2022 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiFBCG5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Jun 2022 22:06:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53344101EF
        for <rcu@vger.kernel.org>; Wed,  1 Jun 2022 19:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654135615; x=1685671615;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=fvhT31EIgGdwzEfqlJyM1l9H+RDgxgMsfRiUkFFJLog=;
  b=B0T9W19lCwwVOVRES+PFNwermkpRx5JZaqr83Uy8kF7y/HC1b+rjm5bV
   ntHN8GO8bO31YRjnLgjy3H91E2NcTjf5SzzHWVCe6gpkfqWBK9k37oo67
   X3TlrNqGPebMbs/sBzItfCA5yStUj2KCJDbKesMSGHScd7aHLKPqjLlrq
   gw/FbPmtL4qA7bMRRzEUj1aY7biZVcefhi1/Fa+NXE2zRc1lO4FEIB0/B
   yiCz6WOlaFqv1f7kSV2FQIjj55RARSOnR5GJS/YyJZbJfmKD1sD1UybMf
   0wtldkvcBEFcBejWGZMr2hq+UHWM/sJyYW02JGffR2/L/S6K++7cLyWGj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="255660306"
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="255660306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 19:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="645768053"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2022 19:06:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 19:06:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 1 Jun 2022 19:06:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 1 Jun 2022 19:06:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 1 Jun 2022 19:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpX4jExJN0t4xc23X3wWXjCdhx7BJyUtRk+FQKgx8H2RUhhmkY5na0LW78XuxglBOdwc6K+dgv2Tjjsco5WCBrxu57oJXtgcS2uXa8IGe1Cs7NEm6ak4efSWxV4UYL2kaK9iYD67ljX7wbdGFwT8w/obhXEz+35m+aR3C3P/NhZPQXdm+qf8oz1oXsgJQM729hMFIf1I5oAThbD3R6UV0FcpSXjDUppC2pkM8HWYp2QKZvU3TYydBO+ZqrPnnUlMpxTwQ1EJEF0afb/pFPfCBkDNRYiZ7CxkibKtQAQedCpF+H3Jj9K/a6njRG/FWSkGxMxbAOwVUQBOsGbc8alxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwIHIVaunjDGSXD7doxQyNKtcUSG7PbripXBkKMOJXo=;
 b=RwxHL7Lfs3K9Zx7yPFZbUwQh23m7psP9tzRWtKsdURMHpavhAf+Pi7lOfQg6h7tCtHher/FEyS1CjSEXzT6Mk3kakk1zogkrumpG1R1ZAyIJE+VUTUkNnRMhhYIspipFXp+tWAsQ9BKPN8ijY0xMgj/h4VJ97yPqmzXgQr/fFJaxrracUPXSrSNxRO+0lccms62MgAt9/8nNaxsCc/tQARB7jZVdtLE+UOXULJWdU8Ug/t8z2+76iRWZlbKjofXqZcubaWZZWdxVaRXQkNCS9PirOpyDec4ITWuEmnAfdnnGZWvBXwbU3uPROo9y2m+iNQEstFxxtjfgOXqeQMEvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR11MB4084.namprd11.prod.outlook.com (2603:10b6:405:7f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 2 Jun
 2022 02:06:51 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 02:06:50 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "frederic@kernel.org" <frederic@kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: [Question] About rcu_nocb_poll bootargs
Thread-Topic: [Question] About rcu_nocb_poll bootargs
Thread-Index: Adh2IdX5WBxfPCDRTXiD1Dt/WvPIPw==
Date:   Thu, 2 Jun 2022 02:06:50 +0000
Message-ID: <PH0PR11MB58804878EF58CEB821D4C4ADDADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f6122e-e995-441b-971f-08da443c8eb5
x-ms-traffictypediagnostic: BN6PR11MB4084:EE_
x-microsoft-antispam-prvs: <BN6PR11MB4084D39A3D30D00714F47EAEDADE9@BN6PR11MB4084.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkcdSxopRMMkxVno8lLv6X/BFAS0/Ziw06y/nZuoAMo1rdfvCecwTb0fKe7n+4nrr74CfhEEFKkLiYQ8Evg4GlSKLOjw9dneKJx58eWCUxHf3yOsiKcQdbLAHtUebWO9wkTif4PBcZJkUNZp9V1w5mxzYlHFqXAh9ovRe19Y7QMgXFzCLmY/jqTsSU7fSbQXfswhvo3LCu0Cs3G+T3oGz8Ca2RS1fibrdx2oeW5HtKttndYxxN/A6glVIo2eOiK6BgNUyByQJz+wKkA2OvnzwWGbLt1dGJ1MbXaiE3/slh5xrEorkRCOaMjdLl/hgXDyR8fOfe1TBIyWgmK77nfyFclxadPg/22SG2lcIBghIQjG5Rp87DVWka/xaMWa/V4rSBUN6FaBcHi2tv9Jf68Ajgr2I+h6P7tebSQyg5+6C3Yd1/SXfVnqigC0d0gCbJgUokm9o3rZ3jMcr4kKeIsbTtYHC9ePFt9MjeV0Pwr8fKDHiOMnZcTB7iia4Mw8Xc2wdk0wNdt6FOL2nv8pz2zHJf13nOlHli7eG9gBJOvpdoYGMzzDiV9D+ALLhjBntPxCZDh/CeaTs5DlQLRM09+jJ2CrwaBggPNy8ARR2pYJ4PnmmapdkOgu1dZMDCunSps3BkWko3+LodkwxY3f7e/ehHZDtoeMtoQJdNBtiWCXrh6NhM7UUTn7emen2iIsH+KAI1bCb9DOcsOL7WDNoC8YXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6506007)(2906002)(110136005)(4326008)(26005)(9686003)(122000001)(7696005)(82960400001)(55016003)(66574015)(52536014)(38070700005)(5660300002)(66946007)(86362001)(38100700002)(8936002)(8676002)(76116006)(66476007)(64756008)(66446008)(66556008)(508600001)(33656002)(71200400001)(186003)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+qwFkYK3EhP4OahFVjMtoy4NOiRcWn+2Sf92r8nPKak0g4WP299rZwc+B+eG?=
 =?us-ascii?Q?4GGFE+qXxO7In6YAiNN2AewbsptRhCI0kN+CYUti8kFl3Mpa95pYRphxvb5/?=
 =?us-ascii?Q?XsUqLxDo6FxPHPLaigNa4ur0+LUzVIyqe+fLh2WYG/k5g/mNk1NV0mjTa1L7?=
 =?us-ascii?Q?LXSC0l3mGyFIhYA8rKh96maIuxKbcSHR1yAsLjWpBbX7t8EyAthDvUUBPJw4?=
 =?us-ascii?Q?HxBrT9ajI7u7Wgd6juSfGfpPJW/D7/2PKltMOk+xPxM3cmEfBHjdbLIkXJft?=
 =?us-ascii?Q?5hGsfBBfvYFRoATybVS7gPZIaVe01b+Jw5h+b+UHHz4cQL/NqPSwk+xqRemZ?=
 =?us-ascii?Q?B05bjx3UVvpyVh7i4oD4pvcf9lsybS0l/ICpleDNvWfntk4QvsZ8i83SMhLh?=
 =?us-ascii?Q?vheXFgO9462WCV+q8C36nX5cM4HEqvctnRNCFP9Cq+9eauwKIXMonJva8KLy?=
 =?us-ascii?Q?CS45QO/UMKvEfEwZ0x6be2+KZ5DQ9haK6KoglbANTVp1PEqzEMbCOOrAiGOc?=
 =?us-ascii?Q?VvYXB+hyIFvZQRn98PKXFj6AiT/daSFWv4jUtNGfKkzSyhUZRXCircp/Eo/9?=
 =?us-ascii?Q?0FuwsiWmSaArAJxwgfPUOyM7Gv7x/P8g7BjYcQH7hkAcLUyi5bFD8KshJ4Zk?=
 =?us-ascii?Q?aTD7TkpmnOdcL3csoQ6J+sLgP8LH/oFN6Ksk1vzzPyA+30LW6AKK8LkoJLWq?=
 =?us-ascii?Q?+BvTlNTVisS5rYlwkksd5ztTvXOlBhPAB0R63qyMIbJHAczx8C124w5wc64p?=
 =?us-ascii?Q?8TlK0pDtAnkz5Tp4iQfe1/ZVXE7p/y2YC3fSvreGEPjwhYiGj/rsbIrUl1l6?=
 =?us-ascii?Q?wJuXvNCnMdWVZvX2pO8gRL3ziaQTJTlRP0dsBihoJqnEY4XkADXc/J5k3g/w?=
 =?us-ascii?Q?wYMetekGy5SCtyLlwA82tHOdnrD5n7u6CP+36SrcEIWBSZQa+QeZWyKKIH/q?=
 =?us-ascii?Q?rB4rpP5qlgb8urLzoKCcDd0YzpaJDPAvpTmrc4Eu7MKXj8pDGZOogn1KYwOU?=
 =?us-ascii?Q?kq0iz22o5Gl6JK+/ZP9RPckadHDOEhEmlSr5SkRIbLDqALuxGyamSrAWWWKB?=
 =?us-ascii?Q?pWB6QV973NpYUc3ZhbuO3t1RKwzoC4ybowPGvcMsSnQShF9SY1EyMTLlefuj?=
 =?us-ascii?Q?UfGYii3X5OMqZqexQi5Ey6oGR0jnAFNlfPrW/MwRdg8riuPTH7yc2mjMRzpt?=
 =?us-ascii?Q?0f/wZ8bul/f3jVrb9Q/0KwrA+svHTI99wh91MrrOORMQj5A1T4+6QoLMMUQv?=
 =?us-ascii?Q?ZmCn3BL6Lzc1HXrMWLs3hf7jNSMMaj1GBHXePef3ppOxc+CNFfspNTpgLsts?=
 =?us-ascii?Q?r8JumXFmO0ye8suRu0QplHsH/QPNVFMa9ewyE6NqXGk2PG/JIxCGMFL/axXJ?=
 =?us-ascii?Q?pkGR184VQsA+NCPFAvQ25/ihdj4y4Oy3tk7zK1sk4gQ6Tbwd91RUAmckADRp?=
 =?us-ascii?Q?v9ogVe2HGGVX9Ad6JSg6UV6EgyqcobW9Q7DtLr3RSSLbC87oKIHYZYF8ya6Y?=
 =?us-ascii?Q?goYXHPvttyjNrIXrnWgRWBdrdk3Y2Skfm90ZyvE7CkNeT4F+OZUgKei5IGpq?=
 =?us-ascii?Q?JHcl/qmsNo7S/A2fGpgFIFxKGX74ZAA+LN8dBXuW4R4impfinjbIn4GCLGOa?=
 =?us-ascii?Q?1IKmGU6eV9DjfzPnBHWZZFzuKJMoGRqLmprawc6VDYduor8CxfIEc0BHnHda?=
 =?us-ascii?Q?Nrjqftt/vmfS7Z3SU35/U0udvAm1+qEfXaxy8zz/VMTaH4tSsklJZMolbGKc?=
 =?us-ascii?Q?OLbjEO/NyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f6122e-e995-441b-971f-08da443c8eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 02:06:50.9026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wb1MAN9Nd51NE9S4SLwIMtIbKg6RjcAprLqIAxPQrLnyyJeqvOU4614ur18T8zLOQvbk4BiCON7YeV2WqvuWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4084
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi All

Currently, I have tested as follows:

runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 4"  bootparams=3D"is=
olcpus=3D2,3  nohz_full=3D2,3 rcu_nocbs=3D2,3 rcutree.dump_tree=3D1, rcu_no=
cb_poll" -d

rcu:     Offload RCU callbacks from CPUs: 2-3.
rcu:     Poll for callbacks from no-CBs CPUs.
rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 0: 1   (rcuog/0)
rcu: rcu_organize_nocb_kthreads: No-CB GP kthread CPU 2: 3   (rcuog/2)

but I find the rt-fifo rcuog/0 kthreads always doing polling, but due to th=
e my_rdp->nocb_head_rdp always is empty,
this doesn't do the actual thing,  Is it possible that we do not polling wh=
en the nocb_head_rdp  linked list is empty,=20
and polling when it is not empty.

Any thought?

Thanks
Zqiang
