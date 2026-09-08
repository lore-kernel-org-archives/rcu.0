Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45647329C40;
	Tue,  8 Sep 2026 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834508; cv=fail; b=kk1a6G5ahRvw91hUYZuySOJMLbXoOQAlekpOBWzFSj3SHoPr/y48N8SRihuFZhUv8icOz4V4k9tbf+Y4QFJrxtmdzfLIbHkwpDwNr2jx++qKAI9zBizEoSxrEefBftrP8A3620YoDEc0Um7p4ThX5XgboUh/Y7RkwYX/ed2+brw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834508; c=relaxed/simple;
	bh=jH/T4qnlyIXiQ3l9AUM4RqTkXiKd6uZcgzwJVPQ2JA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QAJ7c/zhJ/A7WKXt8TSGUprdkfZcyX028cIWarNYGqz6KpKdvVMOW82PG1WV+rw5j8WsjZ6DQQWyfWMJvkxmRLUmQJdrX3lVQz0nDUc5tHCGyRFLtxcKpcAQKRTBZpSKi1LDVSgSUJoVomhbDwdv001wUPUHvpRKbWj36P7qmRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aAGsE2wB; arc=fail smtp.client-ip=52.101.53.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aAGsE2wB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoWPfgtS8vD/wGpybopQTMaLGUpML/IDZ3bjbJl0Akkaygze9s0gEsl42HoKqBz8363pdP5WKYMCXEeVBISAtOAPDbws0wrpt5V877rcYVPi+NoL+uWAz9XFGzbEfcpeI20nuvDt9ziaVW0y2qEPuB1croxGMo5mT6USyskikGWrtihy9cvBgVYLfjpgUsvaifxtaG7UD5WYq0iIQHO9/lxURjGti7/k5h8IFKYVIux4VII/7qmPB9djuWwRPbpOLXf8pydCOj2fnQ8XuVVV8fMff0VKheB1F8P8HTFXrRI0Trn3+iIXT33wsTtXYo3ewCkQb26g/EY+T7RNjR6gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXOUGSWUFSs+JuoIepgj5/nF8tJcoASFm9+3SPI6tM0=;
 b=Or3eOrBtcrSJB13KadWXX7J0GR/T9/ltU7ts3gtgG/SHg+aUxLIVtc6b5hoZJyxPgfgid4Uc2l68tYlB4hbiR8OgQOFxT0G2Ci/XSm0PrDgkXjqegio5BYcwJ6D5lGEnHE1EhdTVmwlPxPnKu+BBCAgd8A5n0lXpV8Qfc3jC4aniFB0XqDHJIa5n6LXxBMg/15DWAcKQ0BCrYA8Sjz/9T6rZoJfnc8wFn3O7utlsGgwzbkV/0QCXM+Lo3aG4QlFw5MgJ0UXCPS2D+8jKPljXKdrpNsW+1lR/h3dBRgj/zL/uJvXACNA7ugeDM67Jt9Z5Ok9t3fwJ/Va7DXvH4G/eVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXOUGSWUFSs+JuoIepgj5/nF8tJcoASFm9+3SPI6tM0=;
 b=aAGsE2wB4J7hU+Cai28YNAHTlKeuXs5RkzGEUCt2L16591P84H0B9+ibxjja4tlR1x3pMfnWkIMZMB2H6o2SjWlfzqMFqwVAebJrgmOM6Ca21rZytz6fRy+IU3AxYXkP7XBM0NkKQpW6SC/3WGcBFCidazfbBoKpJKxhPUvWAYo=
Received: from CH2PR04CA0016.namprd04.prod.outlook.com (2603:10b6:610:52::26)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 02:28:22 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::6d) by CH2PR04CA0016.outlook.office365.com
 (2603:10b6:610:52::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 02:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 02:28:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 7 Sep
 2026 21:28:13 -0500
Received: from [10.136.42.177] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 7 Sep 2026 21:27:59 -0500
Message-ID: <e618ace1-6a8b-42c5-8a97-44b39dd1a7c7@amd.com>
Date: Tue, 8 Sep 2026 07:57:52 +0530
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] kernel: convert process/thread iterators to
 for_each_*_rculock
To: Oleg Nesterov <oleg@redhat.com>, Gregory Price <gourry@gourry.net>
CC: Ye Liu <ye.liu@linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu" <mhiramat@kernel.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ye Liu <liuye@kylinos.cn>, Michal Hocko
	<mhocko@suse.com>, <mic@digikod.net>, <david@kernel.org>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>, <gnoack3000@gmail.com>,
	<ljs@kernel.org>, <sj@kernel.org>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>,
	<tony.luck@intel.com>, <reinette.chatre@intel.com>, <x86@kernel.org>,
	<paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<pavel@kernel.org>, <lance.yang@linux.dev>, <pmladek@suse.com>,
	<longman@redhat.com>, <mathieu.desnoyers@efficios.com>,
	<jiangshanlai@gmail.com>, <qiang.zhang@linux.dev>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <mark.rutland@arm.com>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <babu.moger@amd.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-6-ye.liu@linux.dev>
 <ap7dC-LWNaoPYJvv@gourry-fedora-PF4VCD3F> <ap76-0-hN6CAcYXX@redhat.com>
 <ap8mgnpE7D4TTrno@gourry-fedora-PF4VCD3F> <ap8yoW37GY17pHYS@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ap8yoW37GY17pHYS@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fffa6c6-972f-4438-d4f0-08df0d50daa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|4143699003|56012099006|11063799006|10067099003|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Y/lmub6wWLzzcXb+lNCw6o62BGYMe3q749q+KFXcmStVa+OjHDC7PKuQ+ln16m8/CifwJaz7kG5nrRvxSc2DTEXsiPLc+Ei0ILeJTWVbrirlt3Cu6Kr6sutaq2MU9F2lhXMz6ATyEuht3JRzRVnXbn1zl+ktvyc1g4yCVL2eMMW7Wc1tSEe1lkAJduykR5acPrgFRJ4os4UKyhPdnYyYwuilB+xpxCraU6ca6B3Frc75rsZNsOuRwU3CxJcks5Qy9GHtEh51BES2xykkVCTVO/6eo7e64u9yO/Hk5nLG7uX1E2cfi/XbrQejlDEB084sBlJfeUcwjFh6SB3L8zFSF5aJo/jnLfUWMgRhu+YXSY2HhquFmwn22PB2B/z+PK3J4Z2VgdRaGiaWmOCG2Xw2G4yt50fGuzRyIil/RRZDYZjL+ldhSjR5kSG9YQshp9c/WmXogXqvMcyn4HS1evLkUXvw4ipcog4vzk7Lz0bxdI0YOePAChZj5RsmKC5f+p8o8AVNO6vBdAUU+OMRz3UHchn1+zD2qz1qRwxLV+qaDjClV49F2+k4gQfeLzTc/2JcjzZu/q5DSiww3SI6nVtwTtT+Z2xB9GqA4h3fmFLTiqrYWk3lk1j8yK+hQr/CoZfNLHKmMCc6SorqsYX2pAytWroMPX+I/JJLZtyQ5vN6A5bADJfrU4Qz9Fj5/g24c/NYCuaVhtKvfuuYJ4S53NVXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(4143699003)(56012099006)(11063799006)(10067099003)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oF0cU7jFsjNsgLVPvqCOEaamDDDxhM0Da7HJqKtGq/xtMQyjeEMnq45/UaQ4T4OaQLK9ZW+CsH5vM08pme0FCxxRutR2OMbR6F/wgddOVrnM5FmoPngl0U9XylfsWNmscbdyE2/WYTq0kStJRghuuWoWB/KrFTQH5BzF4zYCSIvy6LznH2wv8UfF9FvSozvpVVWA81srrHUmsP9for6ICg3d9rfBzYBl6L/loVh81JGoSlSJsL+xBXPXUvtLhLSU+8yHJxz7fftbDfn3BIPBlkuuiG67PgORmrBlHV6Q3IeoC8i2w9hBz9ccecCqtKej8t8G2fx1lIxQ+CqCd2gi88FpELtAyCqLeW8BvLek2ILAOCLCvIbcL8OmkO5dsqSGsbA41YsvNyQQOiaE2OggHoG9WcZfVN5I/9nW8RtmI/DC2kxeenpjYbQssJF6KDtl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:28:22.6278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fffa6c6-972f-4438-d4f0-08df0d50daa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

On 9/8/2026 3:24 AM, Oleg Nesterov wrote:
>> This might be my - admittedly shallow - understanding of scoped_guard,
>> but does scoped guard handle goto correctly?
> 
> Yes, it does,
> 
>> and why it's generally discouraged to mix cleanup.h and goto.
> 
> Hmm, why? I didn't know...

Apparently older GCC would allow subtle bugs with cleanup + goto to slip
by but clang has always caught those bugs and refused to compile so as
long as clang builds are happy, things should be good.

Here is an older explanation from Peter:
https://lore.kernel.org/lkml/20260327154136.GL3739106@noisy.programming.kicks-ass.net/

-- 
Thanks and Regards,
Prateek

