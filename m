Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88EAC433B4
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E16613DC
	for <rcu@archiver.kernel.org>; Wed, 21 Apr 2021 23:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbhDUXqS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Apr 2021 19:46:18 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:40232
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237429AbhDUXqR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Apr 2021 19:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By+TPShso+V9xvOzsdj9ppqfFACt8lCNhEjiu8S/kfDAAiXktM5qeG9rbji/B75xEi0AlN0kN0jDsNLMO6SIbosvutSQBBDo/04vyZpHMR54qqz1yx//AXcMics2WK68z4r1RRZtdizomEvXkOCbD8BzqZjOGmHr9DJ2qAjuE/icZ8GA7ZFwFsHquRrrVo/c/Z/gqCSxsyK8y9GRq+MOs0TpBN4KZdB7T8gvnkgNZHdbauL0okhEVAYhyMkz+84oeut4QuaAVTK4sKGUteiUmC66H7GjJPqQcik7m0iW9X+I6g4sOi6TlGuiQ03Jj0V4A8otq6i1chAYDS4h3CZX6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dDdnSL3EiNVtGwVBF2cblrL3zMuuhDvgYxckU+NWm8=;
 b=aSFCKs4m/W1NWWjYdblVqcs3A0I4/pDyoGsS2ollDk84uBzm4Q0UPMsmrM6sCx0FlEP2ROTEsBnTJc2+6DzDsuIcvcwrwVcReAlDwhxp7d5KVTGfaMMCTuyOYJR8OqKpaj2lE9TZAsz/o6xS+46iwj7W8npTuGp6r2fCZSnf9BNUK/1IK0BzpfliuxKFFBQePFsy+d2mWnbvTwqg1mdF8QelN8tNMikXnPVXEy9daPrBgVeMmELEmtN5joscZ/FHRZsGoPGCfzf3P0uwSZnEE9LtjWP8+8AoAbDAxsxUuv5I5XYuwPoTzBFbab3ujZRPpxyTMyPvVhwMS+8MPZZwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dDdnSL3EiNVtGwVBF2cblrL3zMuuhDvgYxckU+NWm8=;
 b=VuHU17seRTao4cB81eRV78a9RnURYMLM/XH0iwly+bSABwYrlo/GNFmaFmHYF3LPbXChD9F6nY0nsTnlydDxrOvruBHgiBWuTjf38ho1e8giy2x6UPU/dDOZXhOEtAK66cl4EHRS8C6ESCqim7jWPFxxAvbWkpGKkqtXFcAy1YQ=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM4PR11MB5440.namprd11.prod.outlook.com (2603:10b6:5:39c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 23:45:42 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 23:45:42 +0000
Date:   Wed, 21 Apr 2021 19:45:27 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/2] bitmap_parse: support 'all' semantics
Message-ID: <20210421234527.GD194948@windriver.com>
References: <20210421031326.72816-1-yury.norov@gmail.com>
 <20210421031326.72816-2-yury.norov@gmail.com>
 <20210421111932.36665920@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421111932.36665920@gandalf.local.home>
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: BL1PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::9) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Wed, 21 Apr 2021 23:45:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a34bca0-c9e2-4cc9-8277-08d9051f92dd
X-MS-TrafficTypeDiagnostic: DM4PR11MB5440:
X-Microsoft-Antispam-PRVS: <DM4PR11MB544030BCC7810BC80A92990083479@DM4PR11MB5440.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZ18ygSuWxsxzucoqKkgkn5el2IPdkzGo0BaA4/HKwnE0hxmFNIdzPiIiNdtW5EmyUvCmHXhjD/RKw4aLPbjCPn6JvrpGkZUXu6qK6sHEghOa3nttrg76fQNiCNKjhHJ8kcXfjJQ59e+34qhO+l4R0//QhZaMfDtCDnOyG1l1faQkpPi6Eh9LBYc8rPjOEA0tSMu3P7rFKxNd7lav7mTBY5M5YVy+2vu/1PNXRolSjMNZ4b24TPRWA/fxhwO6WEpXw/9qePEb46CP5LaqCN3dzB5k/4Ej4mWWrH+yK9kY2XjWULTueZy01pfWhfC2LTNekVh+2qjBtsyMJZuOLurjQ1wRY25ffKNcNebyoMrF6xh+MMmiUonZO/0/JW6s/uVVrl5t7G8s8cLHZAwKBR70EYPRujQbKJfSiYoeDEFKCOZ2b1S8979GKbsF4M73sxaKoThWznnaILDjVXijJEe3dXa90T8l/KGzsl9RUbRLBUQz0VwscMylAg/kr+xFMqMgV+7CmwTlLRz3A1CFHFdHx64udmQZ29lv30cxof0CD7ufK4H5rYNoVJMAckI8rS1bH8lbZgZHSiP9nig4ydoTqQZO8vb1NmmKw75nCX1mTHi7rZo992yxSIy/DOQeC+ekSEDCwnb89MDdYjhjzfpoep/rhbBDeAcNFp0LO6QTJc5YXrLjOPsfx5BiP8RjmXe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39850400004)(7696005)(86362001)(4326008)(186003)(8676002)(956004)(1076003)(38350700002)(36756003)(478600001)(54906003)(55016002)(33656002)(38100700002)(8936002)(7416002)(2906002)(52116002)(5660300002)(8886007)(316002)(44832011)(66476007)(66946007)(6916009)(26005)(16526019)(66556008)(2616005)(6666004)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P0KIkLs7ZhwivWXFk8OnOt61Dt9hnzxsafvYiaW6UNSvsfnILaPWG1sqTNPB?=
 =?us-ascii?Q?YcDVM4AKRn20I/AHRV2PIYhSlGL/oiEuMw1FpT+LBtHScvpafYsgajeg3QN+?=
 =?us-ascii?Q?CD81rM0Lf4QlCXkeMoN8gVrqvXUmbNZgDARC17VUo0HGn/hnJQzmAV+9DgLU?=
 =?us-ascii?Q?jh/SBn5FlCqRZ6t2/IcXG3Bqm4kCwtKD06/v3X+xZ4JMKbeyJZkUy6iE3B7z?=
 =?us-ascii?Q?oLf7WIAMDt/yev+HWB2amqdeNkqgF/TZxTPt3VuooAbpnkVUd5ugWitaBG4H?=
 =?us-ascii?Q?mj4jeAcSJtx4WlGo0RdIeIrlqX9RbGTWmVwt7vA5Kj1B4VPo2zAGs/mlN01P?=
 =?us-ascii?Q?snf93JUvRAQvzgPpYBBqsc2eb3dnsBvYlOuOrX/mf6ZFfOPxkXPdrB+8k6YZ?=
 =?us-ascii?Q?Y8dBEmwfREMdnCGAkiYb9C8YqV0Emjl3KODB0BTliwSRCYuPlJ0seiMBwSYq?=
 =?us-ascii?Q?aiQKKsCDsRvVaMZgooIEwck90Lgi6RiLVXsFhmAD/oT7u3kpzamghwLNpfvV?=
 =?us-ascii?Q?h42KEc9erB26aZ8ZqWRfPujN4jXGI5q5X25iCsiN7Yx4KjWHCmxamVNadfu0?=
 =?us-ascii?Q?GssuplK+fyp9SvYhUwGNg6ddJ8mMu816ktwHcmpR7GPwfaCrhB41pey9qZv6?=
 =?us-ascii?Q?joWRyadamhCWWwVUDiXiGRjETAHN4GVzQc8Jr5orWgQwDwOYfxaRXbc/l+XD?=
 =?us-ascii?Q?BnPKOoiB9i1fUQj7TQN1eXvXQ0rWfuQdeVwJbzfE6dxgVeLPngkQCXu+9Gjs?=
 =?us-ascii?Q?P0h8QeMzzLv49VTW8bU10SbO7Ec1GohbvhYcSkdmZ8dsitqB9dk9VoqPDhx8?=
 =?us-ascii?Q?6RowBdAa3yekwIfsefm5sr51H0/fnQrggZ53WvmDuDRHWA1WIoKLZHkYaGdJ?=
 =?us-ascii?Q?m1V2XpzKV4HR90zqI18oAlCqbzPuQKrOuirBjUiZe3P9tsELECCT0VwWf2xZ?=
 =?us-ascii?Q?4ViOefI50vxizYNnUTGCyIRbuQGEPVcgUlEjixlq63HExaQbVmPW+asLVfl1?=
 =?us-ascii?Q?LfZEGnzDu3DS0D1JCHo74/TmNf4kvml4sjZVDDj9W+HCxbOnYnOL331TzoBw?=
 =?us-ascii?Q?za6y2Kq+SHxCSHpSs90y3pw9UtOlqkdfwKAQvLO6BYcVW48hRxld3LbJkqxA?=
 =?us-ascii?Q?mOmzv4q8hWoDtp9EizehXzThcjhBEkZ5h5BqT5Ywf8+zrTpSd89Mh+mShltf?=
 =?us-ascii?Q?LCM2DsC8pndhKK0hZ0xnu1iiJEYg3lckKCjcV+u4o84lgQTlblwxLTvirRnf?=
 =?us-ascii?Q?M0KJUz/JvyyjzlMiz9aP51b236ff8zaFfqBgxJQNUD8+5hysxiNWLpfVJ0D9?=
 =?us-ascii?Q?m+57oUm6Qn3Op3Q0cVz6qQ9U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a34bca0-c9e2-4cc9-8277-08d9051f92dd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 23:45:42.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k3nN09nMSjlI+zkTf80Rbb9uMTx0svqw7/3Lv2xgk4cs9KN45WSKclgFP8tRC1RfwIBsnwD0EpV/bXCqksCjbZCvMzUITbkEUbfNB9ouyUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5440
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

[Re: [PATCH 1/2] bitmap_parse: support 'all' semantics] On 21/04/2021 (Wed 11:19) Steven Rostedt wrote:

> On Tue, 20 Apr 2021 20:13:25 -0700
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > @@ -76,6 +76,11 @@ to change, such as less cores in the CPU list, then N and any ranges using N
> >  will also change.  Use the same on a small 4 core system, and "16-N" becomes
> >  "16-3" and now the same boot input will be flagged as invalid (start > end).
> >  
> > +The special case-tolerant group name "all" has a meaning of selecting all CPUs,
> > +such that "isolcpus=all" is the equivalent of "isolcpus=0-N".
> 
> I'm OK with the concept of this patch set, but really? That is a horrible
> example. One should NEVER set isolcpus to all!

It wouldn't have parsed anyways.  The "isolcpus=" would just think "all" was
an unsupported flag and discard it before it ever got to cpu/bitmap
processing.   See 3662daf02350 "sched/isolation: Allow "isolcpus=" to
skip unknown sub-parameters".

The use case example Paul chose (not me; the smart Paul) is better.

Paul.
--

> 
> -- Steve
> 
> 
> > +
> > +The semantics of "N" and "all" is supported on a level of bitmaps and holds for
> > +all users of bitmap_parse().
> >  
