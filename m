Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAACC433EF
	for <rcu@archiver.kernel.org>; Thu,  4 Nov 2021 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC990611AE
	for <rcu@archiver.kernel.org>; Thu,  4 Nov 2021 01:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhKDBMr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 21:12:47 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:58140 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231280AbhKDBMq (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 3 Nov 2021 21:12:46 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A419dI0026063;
        Thu, 4 Nov 2021 01:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=CmXaWAKKX0TjBS08BaVW3nFWUSdPV76afH3bjXKuTG0=;
 b=gLFU6iEwafJHdhoqd+WII45BNGsp/6hgrXRu9llgMOgJ3KsfwR9zazxdUUQS2kHiexoQ
 hveUZ5mdQzXveMAqpq8C8lOuRg681IfQ+yOTKBKC8OmJZ10ytguQGtYhU2QxVrScHO9h
 wiiT+CGAo7OlJSAARmMTVc9Gx6mjZEP2w7t9DIQxEqPHofcFRBzoeS+1CMDoxrP6ETMI
 /HDaFImyrApGsc2ZFiMR3RUTCfoT2Z8JaTTLKGa5IxA++Wj3dO8HVQqFj55DulRwGThl
 IXAwYuFj8DpdxB/IEix/TdiySf1F7rz3gXLUTBXYpN6r7x5YanGTtUQAMKOqZzD+avD2 /A== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c3dde9766-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Nov 2021 01:09:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLLM3QYIslUXlAplvhaeqENfu17vbFCL6MZVaPHzSS3QsXWvCRcUc+sqtkEvC/ISSrhEq0cNiZSe5F8a3govlSzpAFox9nxdC7wwzivgl+eoonj9Dm+h4nK3uulIBifl3mMEn7TboOb+BBJuHwb0ImuG6CTREhriN3Xw+mWJi33vbcdezcqSE/zEx8Blwfu9YXfNCSPE1u7uQvn+XwQaMqUL8OCSbjUMVwUCzyVSqYR8xXHXt1B2D26tkGECVhk4aUIfj5RdCasTU8rugaMM5dcotIIIuOKyXNEaiV8Qq7fuVLPEqVYW89j93ZEDh30HSkqdRUQTIoUONRFbDyVUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmXaWAKKX0TjBS08BaVW3nFWUSdPV76afH3bjXKuTG0=;
 b=JeMg9AFAlcv7Sh469LtinGcH90i7Jqqsp9V6Ilv9deE1yfC9v84RwhTWX2RANOGTYgHciIXeXhlLK82YPvK6DrpYTHp6scbea+/pGVxcuy/gSZ6lLoxNf60gLg0EBVkfxkqucdB6KWg57CmsJ0JH5HGFcIRTU1F91faBnglp88XtaV3OsJuIx6LKb67bcm7Xpu5UhNizqdtcQuz7Y15UcMkm2nUGxgn4hldG8T427zA6ZuFCSf3Jz6JcPWbxLuzRnmvs6yZ2/1VqonkeAUUIRHQIwsJI978lzqdCVBQvvYbDB1b9xmYDP2CjjXqvUR82SQGGshWNrALjUI2r9gGKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB3785.namprd11.prod.outlook.com (2603:10b6:5:13f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Thu, 4 Nov 2021 01:09:37 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::3558:2607:4c64:8f5c%6]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 01:09:36 +0000
Subject: Re: [PATCH] rcu: avoid alloc_pages() when recording stack
To:     paulmck@kernel.org, Uladzislau Rezki <urezki@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dmitry Vyukov <dvyukov@google.com>, qiang.zhang1211@gmail.com,
        RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        miaojun0823@163.com, ryabinin.a.a@gmail.com,
        Alexander Potapenko <glider@google.com>,
        jianwei.hu@windriver.com, melver@google.com
References: <20211101103158.3725704-1-jun.miao@windriver.com>
 <96f9d669-b9da-f387-199e-e6bf36081fbd@windriver.com>
 <CA+KHdyU98uHkf1VKbvFs0wcXz7SaizENRXn4BEpKJhe+KmXZuw@mail.gmail.com>
 <baa768a3-aacf-ba3a-8d20-0abc78eca2f7@windriver.com>
 <CA+KHdyUEtBQjh61Xx+4a-AS0+z18CW1W5GzaRVsihuy=PUpUxA@mail.gmail.com>
 <20211103181315.GT880162@paulmck-ThinkPad-P17-Gen-1>
 <20211103212117.GA631708@paulmck-ThinkPad-P17-Gen-1>
From:   Jun Miao <jun.miao@windriver.com>
Message-ID: <309b8284-1c31-7cc4-eb40-ba6d8d136c09@windriver.com>
Date:   Thu, 4 Nov 2021 09:09:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211103212117.GA631708@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:202:16::16) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
Received: from [128.224.162.214] (60.247.85.82) by HK2PR02CA0132.apcprd02.prod.outlook.com (2603:1096:202:16::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 01:09:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b3e5d5d-f2e4-481c-8830-08d99f2fc4e2
X-MS-TrafficTypeDiagnostic: DM6PR11MB3785:
X-Microsoft-Antispam-PRVS: <DM6PR11MB37852722A24541877AFDDAC68E8D9@DM6PR11MB3785.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HP6r5kT8ZUeygzf0qL8At6yT/LhU9n/Zjg3cGpjY3m0jVRbVo7RpnVTLSAQvpgNf06LRP/u0TODonJnKe7BYo9tIMjvHrM//zyLS6BpHh+5wuraqKBSWpCe3qCoEwO+i5c8qGN8+2VWTFIZooaieZ2L0Wg0V+Mh0/mladli/oMlERVMWjmRmtIIkWqPmhLKXTBbk8Q3rWeQLkNQ46wLxJtqLc+50j0CnKrJ0isT3X2EanpjiDfLjDae90nmoF7HMOEBF7FmH8t+eY/AzkDxu8gKGAwTFAdn9YfEqRbdQZC5DIjg6aDa4FKq9CK+6fOorRfo+TJ74yPXP+vidYtDUudWCjyK8DyyUrmOzGlvp3O2nbgSTJqyK+tlP1OAnvlfcM02Tk5863+WQ1GLYA3LsPMNCuvvNmZFhwQ0d9xR/B0VI5D8CHk2kni/ZoU4GVU6+nw7eTOGm/xylgg7qwX6m+EUxLx7XPRjjNGdzOUzv9OLbTAR/Lc+B/Wn8ll51IuHA9TjLGMleZg6gB6DsPOVK6MfjusW53AhQobU52jK/D/LBsUAqG3XKS+/jlg8mWEWAsu+qfJz89ojNPDbmfqZVUGJYw5ZmHoyzbGqmhoV8oB9XAAETfDcF+yZoEjlyiCRT+c8b4B7+G+8y0/TVs1T70CcXBh0KrU/3A1AHwTD0yXKQL2MQtY/8DrjSspqajaVUm1EAK7G4WBtFUvQvDoZt6Cr5QdCS7D6dapVZdjJgYGL4Kt5o6MQ7QBAy2xL5irv5/vxUL/nG3f7aoDAnjmiWxv6d2Nv30ZxnZA3uVsAMc59lvLVSDh21oyscw1Pxe0ctLe1W372Ma73kTxE9nBDwV7aeQbW6/EU1rqFKTSAlWs1S8OmIz+j2SRoGfyhbZRMX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66574015)(2906002)(26005)(6486002)(86362001)(66476007)(66556008)(8936002)(36756003)(83380400001)(7416002)(4326008)(53546011)(66946007)(31696002)(52116002)(186003)(31686004)(956004)(316002)(38350700002)(38100700002)(6666004)(6706004)(8676002)(54906003)(508600001)(16576012)(966005)(2616005)(44832011)(5660300002)(6916009)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3MwUXlaWENQdWloenZKTWlUcGtCNU5yZkFoL0lsZUloVnJVcVR1K21mMUxB?=
 =?utf-8?B?L2FhSklZd0hoeXJaems5UnFYQzhLOTY0V0ZPVjVRazRiUDUzVlp0eHY4TUVj?=
 =?utf-8?B?YkxldGNaUXF4NjdCNmxQWmM2QThJcGk5aUtYWXg2RG5EY25YWFZMWCtidk1P?=
 =?utf-8?B?c2xsMHRocjNta0hJUzNXYVJ5ajNCNldOUzVRUmJaM0gwMVRNaVJCaGpTU25r?=
 =?utf-8?B?eFRLSzk1S3poYjBzUUo0YWZ0OTZLMUZ3Q2hsbHJWaU9PZUtZMi9KeW1NZzRh?=
 =?utf-8?B?V08xODVRSkdTZGJVSUQxRk5QVVptaC9hcVZBTWk0Rk5DamVxdndlU0JJek8z?=
 =?utf-8?B?MUgyeFJ5VG5BZFRzaXh5NlF6WXYvTG95djgrUG44UUpUVUoyaXQ3QnZPb1Zk?=
 =?utf-8?B?RFU3SVNLRGdZZE1NQTFwNjdLM2pDdlZ1WEVORkJ6cDVyeGhRRlEvVWpDMHRK?=
 =?utf-8?B?MmZ4UkVoL3RqM05yUm4yVFo4THBER3h2N2luYzl2Q2lJdXZtNzl5b1lkaUgz?=
 =?utf-8?B?YUZSdktmdmk5dFdCdlBUSnJ5SVEzYWcxVi9UM3lwZmcyT2tJcEZxYlROZG51?=
 =?utf-8?B?cm56T3Y2SkRMcnNtOUpKNnBWNDEyTDIyYWV2TXg1R0h0cEFJSEhhUnNDQnNO?=
 =?utf-8?B?alpQYjVnL1pGSUh6Ui81bFpPOGFKREVkZ3NYeFk1cnRXYWxvZDBOL2ZlelBP?=
 =?utf-8?B?MlI0SHA5K0trMHM0b05Rdm5UeE45YjAvNkloK2JwcjhucWMyTjFRK05XcGRN?=
 =?utf-8?B?U3J4bjVpQTNDZGJyRGgzVEZoZFZvMXdmVVE1NHJCZDlJV0FKUnFsUEQ0NWp6?=
 =?utf-8?B?azZqQnlBYkdXZWZIMWlsSEpWaEdJZWtONHBzU3F0YVc1UEo1QWF1Q0l0NEhx?=
 =?utf-8?B?S0JsU1ljdXdVWG1VenBTSlJpNStJVndSOUVwazRBekFqY3RaNkJtZWRGdndl?=
 =?utf-8?B?MlJVQ2hIRjBFMHBYb29IMWgxQkNxcU1JdllqRk1yWFE0aUN4VzEyTTZJWWpl?=
 =?utf-8?B?QnVsZEhrU2s1Vm1YenR5ZlpQMGJTNEdjQ1RwcmEzWVdJMTE4VGc5bVltU0ww?=
 =?utf-8?B?b3dPdGpQZENVQWV1NUU4NmRLV2gxc2NVSkx2T2ZlcUxWUkpWVzdIaFZyYVg4?=
 =?utf-8?B?SC9uVEFiNk12MFJOSUt1U0pTUTJGSmVoeFk5WGloOG1RSXUzVUZ1cVZTbEhz?=
 =?utf-8?B?bGhpRkZlclp5bXJtYUpwZUpVQSs4TkRWVExILzNHUzMzNFhOZzdLa0pKbUxH?=
 =?utf-8?B?TU42SjdyTy9YVGRFVzVpazhzaEhKNWdWalV5eG91K2t5V3c2WUY4UXlLSGZ5?=
 =?utf-8?B?RmdRT2l2dFRGdSs3OWs3N2tkbXJNSnJwakRLazFpVzE1enIwVHgrRXBjdTNZ?=
 =?utf-8?B?Y0d0S1J2aDlvbWk0dk5xZDA2YkJJUDVSMU5YdEEyZGFsTUk4bDJkTGRIcytu?=
 =?utf-8?B?Nm8vQ1RFRDdzN3pVNHNmMFF4aE1xR0FKMWFySXMydnpKazlhL29ldW4xRzZq?=
 =?utf-8?B?Ums0aERQSW9oOWtFTFFQU256azc2c0FFWGdMU3FtY2NrSHVXUHpzN3ovNHN0?=
 =?utf-8?B?Q1V5cTlQRjlkQXNva2c5ak5IOVpndTIwQnN0a2ZjNW4xRVdEdnRvN1dVTm1x?=
 =?utf-8?B?R2xUcmFybW1EaTNyYVk1RmhWRTNEakRkTkFNbmIvTXVDWklnV0JBdGd0TDEz?=
 =?utf-8?B?eVRkdDg1ZHRVVi9CcVlzb255MHZ1QU1vd2tDMVlvSC9uWE1EcE9RU1lpSnRQ?=
 =?utf-8?B?eHlaUkFMNVFtS3ZzL2lzYVNRdnJNRktmNkhuaUZrNUJFSnJzcDNSTktEcDN1?=
 =?utf-8?B?Z2lmV1VSSnNBVEFEK0ROQUFQRUNmQTdmWlNzYUVGUW5BSFcrQlYrdFBzSDIr?=
 =?utf-8?B?c05LeFpmZ2J6WC9MZmFmRW9hemE0cERPMTVQZ3hzbW4ra09hN1RmR2JLTWJJ?=
 =?utf-8?B?S0cxSGt2MFYwbnIwTElWbFBYZmYrdEUyMGNNeUlSdVVwaVo3VkIwcnh6MzBs?=
 =?utf-8?B?VjkrMUJSa1ZieW9tNEgrZ0hRTXlZb3g3azFubGt4ZVpER2xyRk5vNkxSVmJj?=
 =?utf-8?B?MllUQlhXS3plUGFGckloZDJKMEZSb05Fb201N3Q3RHpqY3BMbktidEFLc05E?=
 =?utf-8?B?MCtWc3FKbGQybVg3TUY1TENLWGRvT2Z0cE5RS2xPNzE5b2E4QUIwWHdSUU93?=
 =?utf-8?Q?4YhQDJ6jECa3SsdgTka3y78=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3e5d5d-f2e4-481c-8830-08d99f2fc4e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 01:09:36.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR2yzhnP9Xp9OqFD+1U99G0mR9vgSeMhAigar6XSWOJHYzJ/b4KCX0tdP9SZgTmb5mjQzNG3DnM/s5AODWD0zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3785
X-Proofpoint-GUID: NYz4m9ITAoMDiLNgIEj1DLq7kKhpD2Lp
X-Proofpoint-ORIG-GUID: NYz4m9ITAoMDiLNgIEj1DLq7kKhpD2Lp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040003
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


On 11/4/21 5:21 AM, Paul E. McKenney wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
>
> On Wed, Nov 03, 2021 at 11:13:15AM -0700, Paul E. McKenney wrote:
>> On Wed, Nov 03, 2021 at 02:55:48PM +0100, Uladzislau Rezki wrote:
>>> On Wed, Nov 3, 2021 at 7:51 AM Jun Miao <jun.miao@windriver.com> wrote:
>>>>
>>>> On 11/2/21 10:53 PM, Uladzislau Rezki wrote:
>>>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>>>>
>>>>>> Add KASAN maintainers
>>>>>>
>>>>>> On 11/1/21 6:31 PM, Jun Miao wrote:
>>>>>>> The default kasan_record_aux_stack() calls stack_depot_save() with GFP_NOWAIT,
>>>>>>> which in turn can then call alloc_pages(GFP_NOWAIT, ...).  In general, however,
>>>>>>> it is not even possible to use either GFP_ATOMIC nor GFP_NOWAIT in certain
>>>>>>> non-preemptive contexts/RT kernel including raw_spin_locks (see gfp.h and ab00db216c9c7).
>>>>>>>
>>>>>>> Fix it by instructing stackdepot to not expand stack storage via alloc_pages()
>>>>>>> in case it runs out by using kasan_record_aux_stack_noalloc().
>>>>>>>
>>>>>>> Jianwei Hu reported:
>>>>>>>     BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
>>>>>>>     in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 15319, name: python3
>>>>>>>     INFO: lockdep is turned off.
>>>>>>>     irq event stamp: 0
>>>>>>>     hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>>>>>>>     hardirqs last disabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>>>>>>>     softirqs last  enabled at (0): [<ffffffff856c8b13>] copy_process+0xaf3/0x2590
>>>>>>>     softirqs last disabled at (0): [<0000000000000000>] 0x0
>>>>>>>     CPU: 6 PID: 15319 Comm: python3 Tainted: G        W  O 5.15-rc7-preempt-rt #1
>>>>>>>     Hardware name: Supermicro SYS-E300-9A-8C/A2SDi-8C-HLN4F, BIOS 1.1b 12/17/2018
>>>>>>>     Call Trace:
>>>>>>>      show_stack+0x52/0x58
>>>>>>>      dump_stack+0xa1/0xd6
>>>>>>>      ___might_sleep.cold+0x11c/0x12d
>>>>>>>      rt_spin_lock+0x3f/0xc0
>>>>>>>      rmqueue+0x100/0x1460
>>>>>>>      rmqueue+0x100/0x1460
>>>>>>>      mark_usage+0x1a0/0x1a0
>>>>>>>      ftrace_graph_ret_addr+0x2a/0xb0
>>>>>>>      rmqueue_pcplist.constprop.0+0x6a0/0x6a0
>>>>>>>       __kasan_check_read+0x11/0x20
>>>>>>>       __zone_watermark_ok+0x114/0x270
>>>>>>>       get_page_from_freelist+0x148/0x630
>>>>>>>       is_module_text_address+0x32/0xa0
>>>>>>>       __alloc_pages_nodemask+0x2f6/0x790
>>>>>>>       __alloc_pages_slowpath.constprop.0+0x12d0/0x12d0
>>>>>>>       create_prof_cpu_mask+0x30/0x30
>>>>>>>       alloc_pages_current+0xb1/0x150
>>>>>>>       stack_depot_save+0x39f/0x490
>>>>>>>       kasan_save_stack+0x42/0x50
>>>>>>>       kasan_save_stack+0x23/0x50
>>>>>>>       kasan_record_aux_stack+0xa9/0xc0
>>>>>>>       __call_rcu+0xff/0x9c0
>>>>>>>       call_rcu+0xe/0x10
>>>>>>>       put_object+0x53/0x70
>>>>>>>       __delete_object+0x7b/0x90
>>>>>>>       kmemleak_free+0x46/0x70
>>>>>>>       slab_free_freelist_hook+0xb4/0x160
>>>>>>>       kfree+0xe5/0x420
>>>>>>>       kfree_const+0x17/0x30
>>>>>>>       kobject_cleanup+0xaa/0x230
>>>>>>>       kobject_put+0x76/0x90
>>>>>>>       netdev_queue_update_kobjects+0x17d/0x1f0
>>>>>>>       ... ...
>>>>>>>       ksys_write+0xd9/0x180
>>>>>>>       __x64_sys_write+0x42/0x50
>>>>>>>       do_syscall_64+0x38/0x50
>>>>>>>       entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>>>
>>>>>>> Fixes: 84109ab58590 ("rcu: Record kvfree_call_rcu() call stack for KASAN")
>>>>>>> Fixes: 26e760c9a7c8 ("rcu: kasan: record and print call_rcu() call stack")
>>>>>>> Reported-by: Jianwei Hu <jianwei.hu@windriver.com>
>>>>>>> Signed-off-by: Jun Miao <jun.miao@windriver.com>
>>>>>>> ---
>>>>>>>     kernel/rcu/tree.c | 4 ++--
>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>>>>>>> index 8270e58cd0f3..2c1034580f15 100644
>>>>>>> --- a/kernel/rcu/tree.c
>>>>>>> +++ b/kernel/rcu/tree.c
>>>>>>> @@ -3026,7 +3026,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>>>>         head->func = func;
>>>>>>>         head->next = NULL;
>>>>>>>         local_irq_save(flags);
>>>>>>> -     kasan_record_aux_stack(head);
>>>>>>> +     kasan_record_aux_stack_noalloc(head);
>>>>>>>         rdp = this_cpu_ptr(&rcu_data);
>>>>>>>
>>>>>>>         /* Add the callback to our list. */
>>>>>>> @@ -3591,7 +3591,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>>>>>>>                 return;
>>>>>>>         }
>>>>>>>
>>>>>>> -     kasan_record_aux_stack(ptr);
>>>>>>> +     kasan_record_aux_stack_noalloc(ptr);
>>>>>>>         success = add_ptr_to_bulk_krc_lock(&krcp, &flags, ptr, !head);
>>>>>>>         if (!success) {
>>>>>>>                 run_page_cache_worker(krcp);
>>>>> Yep an allocation is tricky here. This change looks correct to me at
>>>>> least from the point that it does not allocate.
>>>>>
>>>>> --
>>>>> Uladzislau Rezki
>>>> Thanks your approval. Could you like to give me a review?
>>>>
>>> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>> I have queued it for review and testing, thank you both!  I do have
>> some remaining concerns about this code being starved for memory.  I am
>> wondering if the code needs to check the interrupt state.  And perhaps
>> also whether locks are held.  I of course will refrain from sending
>> this to mainline until these concerns are resolved.
>>
>> Marco, Dmitry, thoughts?
> Well, the compiler does have an opinion:
>
> kernel/rcu/tree.c: In function ‘__call_rcu’:
> kernel/rcu/tree.c:3029:2: error: implicit declaration of function ‘kasan_record_aux_stack_noalloc’; did you mean ‘kasan_record_aux_stack’? [-Werror=implicit-function-declaration]
>   3029 |  kasan_record_aux_stack_noalloc(head);
>        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |  kasan_record_aux_stack
>
> I get the same message after merging in current mainline.
>
> I have therefore dropped this patch for the time being.
>
>                                                          Thanx, Paul
Hi Paul E,
The kasan_record_aux_stack_noalloc() is just introduce to linux-next 
now, and marking "Notice: this object is not reachable from any branch." 
in commit.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/linux/kasan.h?h=next-20211029&id=2f64acf6b653d01fbdc92a693f12bbf71a205926

--- ---
Jun Miao
