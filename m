Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433134;
	b=FKqQwqa6XicmE906oQs1GHdoa68CsfCbnejlAYij6npXvVPKCT1AXF3y8ERuMYMqPHma
	 FqEGjSafRIMAipmYuSAEwXtU0BxS9oHF+raV5wJODI+CeUo21Xms1mk7xCCAYZJrK3gqd
	 5EgBwrhdlKIzgXyTooDooGbiYv9R/eatXs6jSkoJYx78p3szf9hOniE4XvBU90Q943d9j
	 sL6VPGFg6JBpNAi2//QhXhAM59RuDmgzY54bk1uNCDjnu43Pyhv7s3quXIcwBaucnZxdf
	 fd4ryepMz4PoNh3SjmN1E4UJu9BHp4P2S9aYQJZxLHktixGOcoo8TBG8Rzk4jTvEGqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433134;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=yf4B6jMVXFLuSvIHVQEvWz/xzCKQiqUkgtG5RTiGWgQ=;
	b=ebJxdS6I6FLwwvu6I2hL7RrdH1YUTBH59th5j/I9Vy6i52Q57EgHUbAh6DC4ePpAKafE
	 6fKW7Z95t1cVcO06jss6O/0MumpJYaIVQOggmxYkN1v+H005eNxtfnGAsGC4/Vcm+CCrA
	 ixJuoFa6g13r9YdiFvL/lLQos9xFt7299DXSjk98S7d2CaKMiQ/yUPG2PO3gjXHropAtj
	 qlvG6rUt2zT2oqJSUB0vHFWm84h95LLeTefYBxLATmhfcr+7191f+SnJVMvVyn7VD85dj
	 8DOj3vsPx33A0Ly0ZvbmDIzYYCT3edtySR05Z1EcvG+pqdn7k8Tpty/AK1JboUi9KAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="mBc/VgGN";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86D60A2605;
	Wed, 11 Nov 2026 21:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD86D60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mBc/VgGN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gk0UWgJZbNdb8iiq7svP+5SqlefkQpJS19ePkJLQrV/FOegAOkiGIlh6bz1TcFHYW4s8KB/8WNhwQjgkJ8+y/ptnLXpp9+oQJoklOvjM4roP/5dfvJICSwcDJf9LktQbjzR4iQztVWWZPqIXJAy0pwal+qz2U4aPaJbHtQJmt0dZccob5ysNiH88RXEBBo14ErtH1VVXBlYd6uqerzh8QRQ+kRrIJa7IENn9ALMU15T1XNTncj8uZapiMOHPdsVGYjqMCu2PonyKhnd4vInJx72RIy9BA7s5U6IwfCH0jJzsFKAy7bOIcY914sP7G2BPPMGC/ta00OUHfBpnL07UCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf4B6jMVXFLuSvIHVQEvWz/xzCKQiqUkgtG5RTiGWgQ=;
 b=hZcTgdTMgWE4F6NoSGjCdtM0J7YIaNodcT8y0/BueALYI2OjyDOnLoBOtwlturmmr77I3ASas1uzriwceskJh+cLoeOFsN3LTpmWD5FzxNbaR487utkWMZxrrlqOIydWDwrN5/cdxEydZsGLm8vl6Cs2xthH3kruc7bIXg2TkZMmt056EAWBgBHE+60lmG6XskMwcFkN75p5fqK3sDs6Kj4jiPvyNor9SG0Xo5b5j6UyvyefRr9IgB0sTLP0HtANyGLIASSl9K0VhAqHTYpIxdBrgw9M+QLckqVQ4iTOQerCK8E2N9RPKNCPmyrpd5z06RHds/GthI+aTx2zLwQi8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf4B6jMVXFLuSvIHVQEvWz/xzCKQiqUkgtG5RTiGWgQ=;
 b=mBc/VgGNwJ3Icy8N4wgxzg3EF0o9SGnvjL3dyH7TVdU8BwnSLRf2JgjcLOktpnNooZUnoQbPFf+MEPK4TLjQc3chvOVAI7Otp9jcQSJtfrHi97oLmpfcRlkfOW1H5Ssdt/Q+iJUXP6i11tLFedFnS+hy2yhVvLS72Sw2eJVsshXLqyCbHOC3ITbEsWhpcVGhJ2hJkG3epkSVZGkB5GlLG+tbhBZnZgeKsnu4ldZBuR9OJHJGtW8gfLp1i1H2gqH1Y84Ae0FWBqRveQeregcQP8EBopgBnreXPMeNJ0aJnVhRuHNlldvkmFiLE+lEz+b+GLX43zoqmSdgqsOaSTIN/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 21:38:48 +0000
Received: from DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6]) by DM4PR12MB7742.namprd12.prod.outlook.com
 ([fe80::8df:c519:298a:94f6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 21:38:47 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC 7/7] rcutorture: Make BUSTED-BOOST disable RCU priority boosting
Date: Wed, 11 Nov 2026 16:38:25 -0500
Message-ID: <20261111213826.2035045-8-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111213826.2035045-1-joelagnelf@nvidia.com>
References: <20261111213826.2035045-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:408:e6::18) To DM4PR12MB7742.namprd12.prod.outlook.com
 (2603:10b6:8:102::18)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB7742:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1243c8c8-e65e-4ee8-986b-08df403c2b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|10067099003|11063799006|261021123027099003|56012099006|261022105027099003|261021121427099003|261022075727099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	Yb0IN1kpnJzZqgWfxKQcFMI5Mys7tWOSa02XUrSeAn/WR3xwr7RHZy8nENa4CGx0qCMpZfZFF5S+5sddPR3lXoUkmsI14gzxx9GEr3giETueokmtjwbAbwQVhosjQ7OYutouKdjQC9erJRI6Vtakxmd8kCEqrCEhzLArsg/oc76wvhlkV9mDjF4+sY6PhlzmqCUvsAqYaEX1rMN4tD5wpi82mZJPxl1wjgLuOHcNZWa0epx+8aTiQxWGHfIcqVzvm/9fzgNEjzttXf9vFnlF58INo8uh/PR2RFUUhHu91XVvJVsyOF0N+BHCAt9zxM5Sprhb6HLyDzGhcJL+qaWRMRj5Ki34EI2UcLqtnVJivA8NSaVT5RNVmzGHLOyREHBLV43QHr/KRvDwawaUpDe0yz9YBnpMMFKPOxHFCO08YTOpharhbSz/xweuaL07TZxKxnMmefbvV/meIAH/9mjzXK3DNJaUctukqsdCbaWP4qFJVsXoyOikN6SCqj4H1hRiZWWRbJYnduzom7oZgRwvv3+1OzSHjQak/eoe+GycPUNBb/pz1p9JtJEq6iBINfkQ7I3BUI18T2DiTYtjnnv7TGfNNS2nefKW9LV0RdG1us6kHj07hmQh0mwyR7O+3fuhtR3nk9dqRTWwz8DpFI65Xz5r1AgBhtgcVEd1D/bkmp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7742.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261021123027099003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4NLf/ByhYluMlgRj8ur8FjscNjkxemAC6coEeDvLfAiRglzZrZ42CxLjFBtd?=
 =?us-ascii?Q?6yTT/psXcCTh5ajAyQbg8l1Sv29kffer4IKrRrxev+H64IJVY3xKvO4z1Zpl?=
 =?us-ascii?Q?YG9gKjXAn5XaV2SqtVPQ7IwaXq9MehWj+cDh+q7pIQW4RvhUjBoAzxSTzniA?=
 =?us-ascii?Q?0FFHKbCRlfxZR2s8YUch+DxwPwteKtd2ezv6ftUJhD0s6OYuYYPJ0OJZc/Lo?=
 =?us-ascii?Q?Yvz2PwRoccNEjfI5j5tlkuuDQi36J6b/hAQqh0lHTl5xf3wFto0q0Y6fGIty?=
 =?us-ascii?Q?ooEA0wpDMAL7e0mdxZHH9GNyQ/4zq4r1zROiTJMXkFZeSNyVl5twXBx5pu4I?=
 =?us-ascii?Q?zNK3IrZ7vE+Y4I6L0fE3qWrwt4bf+74YWEVdMRFjlD03MvD1OkpBSyYVc2C4?=
 =?us-ascii?Q?+7GU1eJybHjbj1Qnjg4o8ZrnfllXhvj8/2kgcSoOcCxG//LAbjmqEFbXgDAS?=
 =?us-ascii?Q?AI8mB+j5mCfIeeRA7kDvK2Wz78DW6lOR/2H8UXwpuaeMC7VaTs4COuNjCiFT?=
 =?us-ascii?Q?sc9awggo2Mus/+3KCt/aUSHDwYJrwyxPLGmV1Anzt/OvYA3bM45eXgwkqEWI?=
 =?us-ascii?Q?iqyu144CwNwIe23RQdu2epStcb+TWW1PCSddh8wJgKRiYg5VFbIN5F/Iqo7Q?=
 =?us-ascii?Q?ZUaDbOC48nfVZpQn4Np93Z6msSqPHFHprSwcHUnB33zBhexFHZFQJu1xDo3Q?=
 =?us-ascii?Q?mtvkL370ev0OhgKHoywf4AGo5hJ8iurLCBt3S6HrIukeUD4ts9SV9h04JRc1?=
 =?us-ascii?Q?Fo6Zo/xC+Kiun+Bo1yXILgm18s37LQ9oGBTrHE4CyTBPDCsBDodw2SvM7qXV?=
 =?us-ascii?Q?nTUSjoaFhMWgRmvJk0ZglReTBlnobXTrjHtFO9qqo1ejp3E0V9uYHetzpJ3a?=
 =?us-ascii?Q?Om2Op62JcjcUiF6fjSl3N1Q7WZfd1zQjhqUEhf0EITpS6IqY9cwZL/Lh1d/G?=
 =?us-ascii?Q?+3psYyXu6E5fcs6Sjojyx7WZop7A8gn4HvBM24uNLsyGdmtq68Smke2xuH4V?=
 =?us-ascii?Q?St+9snnZpRy3ulr/EzH1KbWXtmfZfc1GGeLdLNld0rz2EY245XY+QEwxm6fV?=
 =?us-ascii?Q?abc4YNgGAbS1HDJ7+3keDjrRmgzS4cBwzxwzzf7AROxKtr6Uh86X5aUZNlkK?=
 =?us-ascii?Q?+j9ry0C9UB/v7d4POdTKfcM6/4upbhtOhLsFOHnQ+SIE1u2l9BAsDRpRyJ5T?=
 =?us-ascii?Q?Jtq3uj9wxlz28MkjqtDHwRlzah3EQ9lYD4YMs9nhZsKKkWl2qRlY1JslMmkV?=
 =?us-ascii?Q?wRN0mkedFCjFGF2OKxsrmLCBuzHisIxCVUm9vChHNXEkLkX3jh6sdcHQvRIg?=
 =?us-ascii?Q?57k3VdAuUbj1MMVIjHGED9Lmu+8a4xr3GHVImuVsBWo82CzfNB1oLkumYn7D?=
 =?us-ascii?Q?yC7XzRYyxQkUtUZVSakVfN1HLFBPEzmtmHcC+RpXltUUVpVOr6Q4pQuMP6Q6?=
 =?us-ascii?Q?AW8FSN2kqQGZUWvchI/+E5vjOJ1UoARj7k5y/Cco0+eW+jLgruQHJlQ4PCRh?=
 =?us-ascii?Q?rHCGduz3hDunIoAiyiVB5pNcAE7k3SYqYFxXLDkeOB3aIjKzTVc+Moax/TVN?=
 =?us-ascii?Q?QLsd7ugA8pJb5Im+FyIBMVW8j3LFz0la8fFRZ/mV5enBBxaSBwvHBIEQ+GAY?=
 =?us-ascii?Q?qt8alrxXviHH2jmH5JdiNu96rU9ZadmZqBoYr53b/jAlojZ6Z9Z7ZU9qqHVI?=
 =?us-ascii?Q?P+HBsbAuXl01zLRXv1LQn2eRMDafoY7+EvWo0m8pqwuwQEFFr8vRAUaJRl7U?=
 =?us-ascii?Q?E+bNG/1tgA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1243c8c8-e65e-4ee8-986b-08df403c2b0f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7742.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 21:38:47.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Glryblxac9Hef59TBl7HjzN0E1ljW9CQ3A2LL6xPiO6j540ikoDVKJXfKXqq2Ka5tAkzAfR0MGGIcEhoKGplIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

BUSTED-BOOST is supposed to fail because priority boosting is broken,
but boosting is now always built in for preemptible RCU, so the
scenario passed.  Boot it with rcutree.boost_disable=1 so that it again
exercises rcutorture's ability to detect missing priority boosting.

Testing: kvm.sh --configs BUSTED-BOOST --duration 10 now ends FAILURE,
with 81 of 84 boost intervals reporting:

	rcu_torture_boost boosting failed
	Boost inversion: reader got only 203 of 2000 ms CPU in 4003 jiffies

Without the parameter the same scenario passed with no boost failures.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
index 84f6bb98ce99..5aa92357958a 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot
@@ -6,3 +6,4 @@ rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
 rcutree.use_softirq=0
+rcutree.boost_disable=1
-- 
2.54.0

