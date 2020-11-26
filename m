Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190EAC63798
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61B121D1A
	for <rcu@archiver.kernel.org>; Thu, 26 Nov 2020 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jlHEg+co"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgKZVZc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 Nov 2020 16:25:32 -0500
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:26400
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732543AbgKZVZc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 Nov 2020 16:25:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtMYvSQIpFuowf3wTcswqPu9vyERaoRhhpYBIBcu8gFdoHj3idSSSD7S6ryJ6UTVDdPk+sovFPZ0EYuq8FvyhrLkA1aBK5ZWQWOa//pLsvxIgeuTr0Rqstpoe42pGAxvrqO+Jm4FpQLH9nteTKH1Kk/GFUizrhRlEMBWTZsUORp5LC4nQKqeTkJCXhw67xXyjVolPi8k5v32LtG6FgSHaC2+EqoXloS7zDV+uQ9TNgR+ZkjPiVc6ejnPzsQAFhulOmo2q4ActjqcgOYDtlL6yk45EVQbhX6Mf8KbJaWfuKlf+FVA8+0Nmw6lSyippV1xdxaU/UxwnFpaU592bOScbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CsLGUQ7rZrNVACq427BGECRjQ+7Ixc/3+SkbHj8Aco=;
 b=ZnbEv5iadztWKddi28D3uNsuxqp1BVpQwMC2sk38WQ18mwktjI2Jnew1Ub5ijieTi3eeb72KEcSZSSf3yTegMx+YMK531n5sL7q24G7mKQq6CU370MGETtAQmKF5sb1JFG7og9TmbZ9m7wi1iQvBJJvgthKDpFBLyqE3MwBXkivtFG5Y1XKwQJ9g1TaC4HzYD3I0isrmrQCcRADhO1ooopX1mLa1B44Kh/s/oGc84HubdFi5M+ppycyqoS1JpTE2WubDx+3SkOf0DENHcFZenOShuyJkQ3A9jPC4weDLz3SZfN9lZ5eaqfxLs/Sms9nPg5Dm5/dJeNmU2ocM494Alw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CsLGUQ7rZrNVACq427BGECRjQ+7Ixc/3+SkbHj8Aco=;
 b=jlHEg+coTvNNkZyTm/3aWYvBJlctuJg1tW5pYQ052FqEzB4EHiGoxH4IsL1QQEw3J6dsT+QGyPCjy2x00lxTxdhT484iYD3O3jXBArRzZDPQuNu33+Ltl2f7jLkTEXTpRwAn1TMz3soD66Ai6AugKog1W1TXF1rXfK9VXe7+z8s=
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com (2603:10b6:302:5::20)
 by MW2PR2101MB1002.namprd21.prod.outlook.com (2603:10b6:302:4::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.2; Thu, 26 Nov
 2020 21:25:28 +0000
Received: from MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a]) by MW2PR2101MB1801.namprd21.prod.outlook.com
 ([fe80::d8c7:7c95:5325:155a%4]) with mapi id 15.20.3632.009; Thu, 26 Nov 2020
 21:25:28 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Topic: kdump always hangs in rcu_barrier() -> wait_for_completion()
Thread-Index: AdbC4sELsDFnKKqwSUucudo1Ms9VZwBKI3EAAAtIoWA=
Date:   Thu, 26 Nov 2020 21:25:28 +0000
Message-ID: <MW2PR2101MB18014505C01027A9486D45EEBFF91@MW2PR2101MB1801.namprd21.prod.outlook.com>
References: <SN6PR2101MB1807BDF049D7155201A8178DBFFA1@SN6PR2101MB1807.namprd21.prod.outlook.com>
 <20201126154630.GR1437@paulmck-ThinkPad-P72>
In-Reply-To: <20201126154630.GR1437@paulmck-ThinkPad-P72>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a1881c9b-afcd-4996-9367-78f54d1fb553;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-26T21:09:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:600:a280:7f70:909f:1fdc:142a:48f6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ed13e1c-9078-43d2-0215-08d89251cbe0
x-ms-traffictypediagnostic: MW2PR2101MB1002:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB10027027301683F0A7C0D41CBFF91@MW2PR2101MB1002.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FaRvd095pDKp1kaMDmPdnQHZbhWput5IqODF1JtgUdwL69gMKZtcxPLFHslMY+0NBxdozEN67ML6UrXoTX9tbc7dyn5lxT5kdNSrd1FRPVQl1aypd8MG6Dk7hPGmGdR11gt+6ytdrA2R/4WPZ/WmlqwrEOGwdn1bWR/cvTsXJZWHP0XVqX88Add/oykiVLy5p4P+4Xz6dYSNT3jZnSPt30vGj30qXYxTg60VSmKfjE5WYdkR6AUJw14kwbXQYObRT1lAZqxgw1VONdanLz1276Fnp5V7EhkjlgSu3YHugQV2TlvNKIjTkH15dbFlKDAG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1801.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(5660300002)(83380400001)(9686003)(478600001)(8990500004)(186003)(6506007)(86362001)(4326008)(7696005)(55016002)(54906003)(33656002)(316002)(66476007)(82960400001)(82950400001)(8936002)(66946007)(6916009)(71200400001)(64756008)(2906002)(76116006)(52536014)(66446008)(8676002)(10290500003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wwcGL5E5CPR64zprxwlzCCB8vcDFyoFDZV9wtd7UWiTc9QqE9WwqPYZ8UJ8p?=
 =?us-ascii?Q?Y6zazrlMgSGuYBuyZaCeV+QytJlFlzydhiPZc2Z+JjWorstgGlOSh/Qt2Qxl?=
 =?us-ascii?Q?VdeovqoR9KxQCxvGA7jBQGCwXl7+3t59KytgXh8Xn6NRjZ78ughWaaH1iWJw?=
 =?us-ascii?Q?X1IzZMjBhg+vLIrrGHf9UtEKKAP9Zoa0qAnx2SXeKN9WirpLQkWqnih3LTW1?=
 =?us-ascii?Q?f9FV/3teOdMbmGKLhELQFsFsjlu2AkJEy3BKkfqE6TzNjI6Dol+XS5jK1YNY?=
 =?us-ascii?Q?BqqLTZ4TUdQiEs5ero0M4ui5+9wXhQJ0Z2KJFbP9IsTtMcPiVL7bgh9X6GlC?=
 =?us-ascii?Q?gHnGshRu32FqkKnioIupSuRPsXwthQ+Ff1ScfWeY9pBCZwguodg+qusyl/1k?=
 =?us-ascii?Q?3cO0lWHpfF5clFgVFt6vSr8qcVLJ6BDAa6ggMiV1JpD0c1SD5q2IWjSteXxH?=
 =?us-ascii?Q?8BkJXv5+wW8bNLLHOTSDdu9JmtHkMPAw4HIExDYJHW8Z2S6NgNKA81UChpxa?=
 =?us-ascii?Q?/TN6gqtH9FJqgV9G2JC3mPoZ0HYR7iGPwc3Y/8z7tb6DZUG6+7fX5vc5/dHz?=
 =?us-ascii?Q?UGlMNiQsv8NFKB0xWis8hXS30EuCtdjHwlSwDGZAFZHfS2BRmDh53eYWmQ3Y?=
 =?us-ascii?Q?QMQKl3bFmxkUli5UVPtvDEpaEe62JM4/2wd6jSG/9fxiJ/eyuIKNAWtPDa0i?=
 =?us-ascii?Q?7SaNF8f2LWQUyn5TuUKfViadYOV8gkNgTFmmWcnFQlqq74phxMzIYIFqg7lz?=
 =?us-ascii?Q?1zdboVm1RRq85qM5DAavmYBkWGZlPjC4rLHtPtqq8QyTVNzavgWXujd09OYZ?=
 =?us-ascii?Q?1Xt/EigXJU7ho2vWzSC8bLRh2e/w+C879Qvr8KkspOXLTEUQYzFsmaw5FT7C?=
 =?us-ascii?Q?QBFqwCaDFAgkMdcdUjEa98iRapn1FgHDidA4XaoocR+Wmc4QWGCA8d3fS0em?=
 =?us-ascii?Q?zRIQ4q1kJ7T5AFC2iHPk+XylxyD7cUhA0V+rUFEr15ov12O0gnQKtwTu1pRc?=
 =?us-ascii?Q?zg40iDJIp/ic5Vrkbuq8bH35zHr5pKztf5AKhU5B7kKRqJo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1801.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed13e1c-9078-43d2-0215-08d89251cbe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 21:25:28.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqZ6AS1l7q369DbND4KGbsTq2nLk8NrX/Vwx9CqXdZG685ZVg5wd+nlDW4rvwlFR43vmi2gdp0WaXddi5yzi7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1002
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> From: Paul E. McKenney <paulmck@kernel.org>
> Sent: Thursday, November 26, 2020 7:47 AM
>  ...
> The rcu_segcblist_n_cbs() function returns non-zero because something
> invoked call_rcu() some time previously.  The ftrace facility (or just
> a printk) should help you work out where that call_rcu() is located.

call_rcu() is indeed called multiple times, but as you said, this should
be normal.

> My best guess is that the underlying bug is that you are invoking
> rcu_barrier() before the RCU grace-period kthread has been created.
> This means that RCU grace periods cannot complete, which in turn means
> that if there has been even one invocation of call_rcu() since boot,
> rcu_barrier() cannot complete, which is what you are in fact seeing.
> Please note that it is perfectly legal to invoke call_rcu() very early in
> the boot process, as in even before the call to rcu_init().  Therefore,
> if this is the case, the bug is the early call to rcu_barrier(), not
> the early calls to call_rcu().
>
> To check this, at the beginning of rcu_barrier(), check the value of
> rcu_state.gp_kthread.  If my guess is correct, it will be NULL.

Unluckily, it's not NULL here. :-)

>
> Another possibility is that rcu_state.gp_kthread is non-NULL, but that
> something else is preventing RCU grace periods from completing, but in

It looks like somehow the scheduling is not working here: in rcu_barrier()
, if I replace the wait_for_completion() with
wait_for_completion_timeout(&rcu_state.barrier_completion, 30*HZ), the
issue persists.

> that case you should see RCU CPU stall warnings.  Unless of course they
> have been disabled.
> 							Thanx, Paul

I guess I didn't disable the wanrings (I don't even know how to do that :)

grep RCU .config
# RCU Subsystem
CONFIG_TREE_RCU=3Dy
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU_GENERIC=3Dy
CONFIG_TASKS_RUDE_RCU=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_NOCB_CPU=3Dy
# end of RCU Subsystem
CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
# RCU Debugging
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D30
CONFIG_RCU_TRACE=3Dy
CONFIG_RCU_EQS_DEBUG=3Dy
# end of RCU Debugging

Thanks,
-- Dexuan

