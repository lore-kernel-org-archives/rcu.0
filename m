Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FCAC433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CF22080D
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 20:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pcaAgtZ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GXNz9dI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFPUpP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:45:15 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45989 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgFPUpP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 16:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592340315; x=1623876315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=O+i6JGV/go1wu3eRIQgMJ8THJs1XustmPbwR4yz5kbo=;
  b=pcaAgtZ88LlF+Ew+Hr2+6bAks8nP5yCO770KB+Vfphd+CC/4rzxoIYbI
   TsN+R/Tt62SrytMBYAiGVxBIMC/usugQ9KZGf9JHH/NFSJeAFitdNcUxF
   KS7k0gdWkDaVNSn5FVD/IuvT3Tv3/kZsHGYXNeK+D/xVlfd3PfUQI1u2v
   y4poHGmkDBEhrizCe9dba6mxnJjUYZ6tDMng6EGK0QtO/4ILEZgyIZgCq
   xc3dl+xQiqs+zFvUBFzHml1X8DPMiQOkGrNudBb/eaL+0npO8WosaarnZ
   Owx06NZzFGwpdB4ny1VdBhDJ351bgqiS5+vqN5bvzzQ67Mut1onpYZb2+
   w==;
IronPort-SDR: hq6sK95paXsekK/qCIb89TiBvtGsuM55fS4RNmzFbfHw6xJPOz17sXuNGN5vEouxUNl7PgXCT+
 v3DeepFE6DQTGSQ5/GQzIZ6IUZRlg38VHKhhX2Vv/UkCy2fg2gnpP9JFd+p5MuT0p2Ce9W/bGb
 yl65Js7LfUQMDkspu5aQdxyiLtWa7LmcfHJ09NZ8LDkGPLVtaqx6Euz90ohIlK6WcavE1iuvHw
 /V9gV/FIZSU7TYaX8NfSAxb+P6h/tEUs+oR0EE85Bdiq7R+gbg+MOAUATnxA8oClW9A8Ql0DKM
 MJI=
X-IronPort-AV: E=Sophos;i="5.73,519,1583164800"; 
   d="scan'208";a="141549978"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 04:45:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNRw+mK0hQZN+88bzl5YtgDYO2VHVR8/3cn4STwTRnlg4TRzTcFmg3Sayih6rhPuAyc4jbqY/qdy82H4NMr0ZSPY1qO2l8M5PCvHuuDunVmoOVVWMFWT98ToUOfb0tfZ3NzngDiWcK1JXHG1y91xsnWCo+c3O17lAEFuLS1gr2q9xUUI4tSkEMgKHYb3re6kRJBCv5cES14Fwr2DbysSRWyZz8WK6fesT35T04I8/fO03E3ydx3wYnMNaOOo9avsC5E6llj6GhyUcoAZEs5JKp3E5WwuQmwl+NwKzepG9f9XI4hDemD6rpLgoymxcCCeXnmBPe+1fxBF97DjUU2R+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNDdlGNDiI1LcO9sSMMLxM9Tx9iJQ9lw8BnPoBvOMIc=;
 b=SjK2fuu/8o51/jXUZUjaXOzAbhp28VSVN0oxNAvA8FRCwsMCBNbporrqRant2axUiRG2ac3VMSQQZLe0yHvodCHQ0MCSUbwV5ttkGXNn+Y+6kT1ria8rEquTI54ep0DyZkIhqY8Lm0My3TPTNnAYyMpfJknyDZdtLcBuuDvUhO/xQyjk4oyUZ5Wo5rh0ZtrUb9dollc9ufR5fdq9dxV1rDGMG1U1Wql4nkGu25SKTHwcfVYP4aiH0u7XxZCayIdgG/Slpd++BvYawWhs4uMj9gPBFh4do6eU1otIqD/8hFQEGVus09Rmzew/df6UO86Whp7b4uivEDzrbxtso0tidw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNDdlGNDiI1LcO9sSMMLxM9Tx9iJQ9lw8BnPoBvOMIc=;
 b=GXNz9dI7JA4c5teTlSjVpzS8/jmXNuH/P79NxweZXLUxTt52YYehSX6sjxuVnyXwwK1pi8DMEZO5YL9jroziVisYvgIl/L1H2G6o+CWfmSGKzEZ3Le+Pzyndvd3g9UhSG6w3Ij+wGBgs+RD9j7aOivVxfnC9eLNn36JVwdY6Gs4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6947.namprd04.prod.outlook.com (2603:10b6:a03:22e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 16 Jun
 2020 20:45:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 20:45:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: Question about list_sort() RCU version.
Thread-Topic: Question about list_sort() RCU version.
Thread-Index: AQHWRBs42t9q8JLtOk6vT+rVgdWIUg==
Date:   Tue, 16 Jun 2020 20:45:11 +0000
Message-ID: <BYAPR04MB4965FFAF956CE124B79ECE84869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <1909772924.4639.1592339084357.JavaMail.zimbra@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: efficios.com; dkim=none (message not signed)
 header.d=none;efficios.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65a97d6d-9d1b-4994-921a-08d812362a06
x-ms-traffictypediagnostic: BY5PR04MB6947:
x-microsoft-antispam-prvs: <BY5PR04MB69477B062F8EC768947425DD869D0@BY5PR04MB6947.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxjlHcmQ1pfr4tUeKo16zQVqaR5C31KdennBSMjMXADT5bTRGvsDAMCGbnvQiUWUUdNd2SX4ohexQjDlpa6rqtiXyoPEz1JCrDtPp6JxKVmjQt88BX1b2kddBVmHl+vKjRdhnVWWknEDsAgMCuCgVLI7/U4aMPc3uXzxxnmOLooBdfw/8uxOjScwTK2mxcXBeNmChrngQ8Th99I3OiYoQC7AEsFlUMevQa0Zj7reRQdw9VcdSKPLjv4hJusiqeUD+5e1qf5o/1C7PbscY55ko1JLnd0iLbs0ccKSd640BSrJcNe5x6vRzdmk8NpYAomY1A8eOcf9MnwmfeEh0yjugg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(26005)(83380400001)(6506007)(71200400001)(53546011)(478600001)(8936002)(4326008)(52536014)(316002)(54906003)(8676002)(86362001)(7696005)(76116006)(66946007)(66476007)(5660300002)(66446008)(66556008)(64756008)(6916009)(33656002)(2906002)(9686003)(55016002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KqJeentajS8FsU2Yasok35+8Q/Lns0GItLBMu8Nd92W22E8P8vJiir43gKC6UwoMyNFKpcZb4TbJdrk8ACpUWScsdIR6G/hQIsFzFO6LkryaKit8iXT8N2X/bDWw1T5P40QBfUW/dnqQiNDHamnbFPRpr9GRg8q3bdL85A750iG1bD7x3AZy5h+DrdpRnoEMqocfKCWygpx0J/ImuW3oNlNtPKytKD0QyU1EUawN0cxm/D2vxZJkmSk7l09IjMO7xuih/kOv8H8+OFmJub45D0kHIal66/O4NJoov1y1QY7cYyNTjDKr1bgmScuc9OPKrxqnlZ0X6oavpaRKp211D+w/RQpoBiBJgPLNROvfapEifUu5AnC2f9bUE+eYGlLrD8GqG6yLAiX++Ti8H0rSsREXHx/5YVsHdlJtZbKrSfXa1574bHVmLkyLaBiFkk7RjI+ZR9qJdwnClLQbCAqR8J3ZoV8OL8XARdj2usIfnUt0drEEoAtaloi+L1wnia5M
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a97d6d-9d1b-4994-921a-08d812362a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 20:45:11.4223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iy3Z/L8JXMsp/Z5Pzg9Lj63G32U8nNIn2bJUWA9DR/GAZUVSYTGBOgHBdu2ZiUSCoyv9qfNZP2mrJh69eqyuQ7JCc2Q0Xz0bcLVN3BtcbLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6947
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 6/16/20 1:24 PM, Mathieu Desnoyers wrote:=0A=
> ----- On Jun 16, 2020, at 4:17 PM, Chaitanya Kulkarni Chaitanya.Kulkarni@=
wdc.com wrote:=0A=
> =0A=
>> Hi RCU maintainers and experts,=0A=
>>=0A=
>> I'm working on a linux kernel upstream project which is in the tree.=0A=
>> With the POC I can already see that significant performance improvement=
=0A=
>> with RCU in the fast path which are replacing rw semaphore, but not=0A=
>> having list_sort() rcu variant is blocking the developement and getting=
=0A=
>> code upstream.=0A=
> =0A=
> Why do you need list_sort() ? Is there any way you could simply insert yo=
ur=0A=
> new elements into the list in already-sorted order ? This would ensure th=
at=0A=
> the list is always in a sorted state, which I suspect will be expected by=
=0A=
> RCU readers.=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Mathieu=0A=
> =0A=
=0A=
It is not expected to be in the order by the readers in this case.=0A=
=0A=
For the list to be populated in sorted order it needs to be traversed =0A=
every time in the fast-path which is costly based on the current design,=0A=
so we add it to the tail and sort it later in the work-queue context =0A=
when it is actually needed after we complete the scan. The sorting also=0A=
takes care of the stale entries. (kind of entangled).=0A=
=0A=
Changing the design is always the last options, I'm trying to port=0A=
the code without having to do that so future users also can user the=0A=
RCU list_sort() version, unless having this absolutely not makes any=0A=
sense.=0A=
=0A=
=0A=
> =0A=
>>=0A=
>> I was not able to find the such helper implemented for the RCU flavor of=
=0A=
>> list.=0A=
>>=0A=
>> Can someone provide information about :-=0A=
>>=0A=
>> 1. Is there any plan to have list_sort_rcu() ? if so when can we expect=
=0A=
>>     that ? (Also how can I help ?)=0A=
>>=0A=
>> 2. In case there is no plan what are design considerations if someone=0A=
>>     wants to implement the code and submit it upstream ?=0A=
>>     (Also how can I help here ?=0A=
=0A=
