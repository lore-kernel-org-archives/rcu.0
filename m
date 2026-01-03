Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0A32C11D4;
	Sat,  3 Jan 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478293; cv=fail; b=FTsPJfHlLd74Dq3sK7BHcjKi5Qs16SR4YueY7Wxg9DIjNWOg56edhwjV1RvqFVdR3aMfebq2oaGECOJXkykLImuIIP7ObObzH1E/spdkP5aWlqSYHJI+pvI3b49fH/WssgM6eyyiOP2xU/RvG9iQhBCMh4hGxMqB3Vkmh1tuJUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478293; c=relaxed/simple;
	bh=/uLX/sn16Yvwe/R/uih0EO8QTRYqzXXG03T3EmEMpyM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fEO6n99rwBY08OaFyOG4jM6dXkOm7LGdqdrPhuKl9l9GXWarvGVfZteKLueD+u4FTiJ38BPQscto726bvlKIHliT+2vOFFxhvjZolQ1LdUxCpaDtFtiP2kba5VBpa8KWbuFB/yo6rMCevKOsDhHE9WsU5LAuFQ4HAD1DhNNFAng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q8bc+sZi; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q8bc+sZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8cU0Xfzvol78RM8EybDDu/7EQ7ib20WF9ykgJ2RyO4OdYx3YF4fAYOH4kG0qnAZgUPQ9ujw1iLWwZwSd2+4pYbubiCCgOo8JCTlOTjV2Y47LnoFygIFmJ76swazuhGKMD7uY5/idkqoTXzDD6JQjAyLedwFPVHMB/+dlHTBT8sBLjIcPZ4Bbrbp2CWIQWrpGrkZf5eyuhNOz+ud1EhQAB/hHwsoTIK6nXUmQ/3k5Um2VlXjgapTeEmH7xg8r3e+aHnGXLiBCqjc6nxRdI8887NRdkN2XkswehO05/gCZ/2vMbrg4WcPu1TPdoB+zBRmn6Onk73QaIQc59ZVzT79VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRcbF6Z74EU0+2J+1QhMuhQ6E6MQ0vDNygQkbr/IM8o=;
 b=JjZz+mf2gWA4J7NtZPn5u7qCikwfhBq/JY40UtkZIgqbZtgUf2Nu1r7rsOmwIkN8RKQAfIb74Hg9MxO0K29wrExmM6ArQ9kxVcRxxQLUKvp0etV1pnguyXIWLJtmP7tvVNQL1xJfkhM3k/myZ4qKaeMKgZwTQSDmH/Vqv8E9FGjcziKzljqUPD5CCNCvpgM67E245LRxdBV7HxSI9GK6+xKbx6on7gD5dL9Eh5NYEHp+Atl5kV8Bg65rwqetVrpL2jr5qCfVR4XSh4XQSdNTYYiCX/VBHdZNhtsnwq+cWXdMsDQPsZ9c8sekLVcsnHejG+6pMAlhCNCvJlBp/9CjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRcbF6Z74EU0+2J+1QhMuhQ6E6MQ0vDNygQkbr/IM8o=;
 b=q8bc+sZisycG6/0ojZGwGbm+ePtLfhnz7S6j1lJoCwoLrvCQyhDd2UXYMUaQntNp5WhYnypXRJaVa2fFnCNq2/+wXm5n9ooCpHyI7YnLbanvzbDNDifJbYO4Ieg2uzn748bjACA+m/f3YYF/0i7+y453IMdH014gZJVAwH41SmaTxRMjU6uBLaCkdQeFJdjEyufJCpvhaciDhgdOeyDIGP3TLHEbHIqxTuhlfedHOaYVP2AGT1AwS+L8A9VVrBqiSmg6hC42dshk+0hLumSHSS36W8Nhvg/cXmpE/y5ry0YnBltF9uuUkmUs7Q0Wq0/oiRAsEb/3c7xhi4RnGlYXkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CY8PR12MB7242.namprd12.prod.outlook.com (2603:10b6:930:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 22:11:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9478.004; Sat, 3 Jan 2026
 22:11:25 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 0/3] rcu/nocb: RCU nocb bypass-list cleanup patches
Date: Sat,  3 Jan 2026 17:11:14 -0500
Message-Id: <20260103221117.521087-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:558::9) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CY8PR12MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b290e74-dd76-4dc4-7cd2-08de4b150931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dgC2Eb0l5n14EJR/Kn1zYDDmYe5X1GrjFiMP5sFh4o0XUZWjCDn/CPXkBk+K?=
 =?us-ascii?Q?ctT6/DnUpUlNMuOLvI5dL9M3Dmyip/dFCKzZfafBpSLVLbYmhWjSD+H7pahb?=
 =?us-ascii?Q?GaT7IoVyY9AKKLyKmNazqIjkdpjQ0jJNyfCVTZvHY1F+JBAkmW2jJ6YZRReu?=
 =?us-ascii?Q?hdRATM+3Je7dV2stL0LaPyq2pkIeN156F9FwCbsF4sygGF9e5VvuXLGtX4EZ?=
 =?us-ascii?Q?lZ8jj1E9EIzZWs0TqIJAosOi2R75fswDgau5LDuY5m5NGOcnnTIOrlU+05hA?=
 =?us-ascii?Q?3Af0Pe38BOFrgbsINA+f0rqh+1WR5kJNNTzZLn5LLpEkfK0JcJYOv+kaUN4O?=
 =?us-ascii?Q?Sw4ruRh+HzlwCpJvxA+1EFgK/SZ1baS16evd9ZcA7kJPVmjygdmdiQKquPIn?=
 =?us-ascii?Q?15NkFVAB1OrqPX1SeV/vE7Y8JjhtiUGEnrFaFICN3OPyaD3+VJfhyuWjfOM+?=
 =?us-ascii?Q?GFOLP9YhaToVwJ9HK9pbEYn+PSFBdAUepz3H1mfCk3+90ENsLtRh8pHpOyz4?=
 =?us-ascii?Q?Vc3m2eWDWxgmi1ntKNhwX7hjdJ6GkItCPAVLudSUu+FbgxPc1Cpnrx4zPh9p?=
 =?us-ascii?Q?puXTGwzztaao+dGcI4V7J8833Wei0yAr66YoiTuXwTC2zT+kri9QK02efQH0?=
 =?us-ascii?Q?h8xn28ojRBUEp5OuGt/CX3imFI9QZaJ0kFQxTyrx1aFrz8+57dIGmroeuYK1?=
 =?us-ascii?Q?yCwGiYqBcoHw0Ozjc8hl/jjEuWenruYK6tUXHd4L+FwwhFmLHBdi7O0fwuor?=
 =?us-ascii?Q?4zZnorvZEeQHcrF1P/J1gs8oofw9Vh6Ow9EYhoQKGiJR964G/26JctmL3O4M?=
 =?us-ascii?Q?pKBQisA7wNbKh7URtgbhfTTbk9wgFfr0BLf+J8EeC+PylHIZgUXb7jwK+vLV?=
 =?us-ascii?Q?KmC8Wg0WTtw+NleF5VI4vaVfK+HSm5fd8FMxoyIDnJe3rAaUwk4ZCQgrvL4y?=
 =?us-ascii?Q?aNnxUf+E5NHX6DK30vMUQHloUhHO06ZRNWO60Ssj4tTeZPGQEzN6EK7Gkj2O?=
 =?us-ascii?Q?nIhEh+yjZ0wi8x/+wdkYvjSpEbSkQjH1IQ+TNzxMRCGdLUoM6DEQeHmy8Puf?=
 =?us-ascii?Q?WbzqtWXlCmF/7sNNsiynjEbk9bmtF5GuxcBfu9nMve02DcAlgOWkWQDkJsrk?=
 =?us-ascii?Q?D5vgwZkH2noSl9jBzQgyuXoGH6ngl4/L/762FsSJEHkPSuPWlz9IHLh/g9Hd?=
 =?us-ascii?Q?+frWoDqasYvBOMKXAAuGQeXpnACFrpmcg5XaV/X4pS8SAMjCfV+WSQeknwfy?=
 =?us-ascii?Q?j6WTrUkTz5cJ9FsQOmxWpmbBPfvK0vH4MJsThBJN9tTT6ad86unio0vnJwhc?=
 =?us-ascii?Q?ct/yraPFMIXw2cIgrqtFfEBYrW+uJcag8eWP80K/FcWWP7izPonDoGrVVRGu?=
 =?us-ascii?Q?xf86IjyEJq8FBBqAUdOUEyeGNLA/i/gKnodsmKBDMu7Sr1oak6odJO8BkCal?=
 =?us-ascii?Q?2mk6ztiywit3aaKdDq+HHfwIj+ADnNUL7LMCgeLQ6JGxGgxL4lSyLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2NBlzo/BpYVuEw/nwk6Tc9/57VfpzzzIqPXv8PLECGCIvg0n5e4pX3+fvEH?=
 =?us-ascii?Q?FFemz+KnlAQA8o9Hf/V26kFoBTzbyI8Nqb8Q7Wr6ERQe5q7CgWlEKGWLf4hD?=
 =?us-ascii?Q?dpXXtv5iXbwUVRxBSLXVoglAgXEJOtateHMDxaj7APzXLnT/14fZMRXtpOdq?=
 =?us-ascii?Q?tEbXYMcMRyReBR7lHnA3h/T1wY1S0zdP/lXUjORxrT08ZeLo7Ffl1RhjhPul?=
 =?us-ascii?Q?jVSoBTOY0AvQO2MkfngsHONpwLs8076lHApQc5KL1AB7a40Aq8KhYWS8tnYu?=
 =?us-ascii?Q?Juo2kF2gohGtBhzPqWLH5zN9CFqCVA83cIjJdc/d8HsDBIc0pKfqShLvV0D8?=
 =?us-ascii?Q?D5I0XyBg65DupVo4GMr4m2TSy7NhUPvDXo8hhnUtIPjwU8f6eFnmaxser9cT?=
 =?us-ascii?Q?yiQ7IG1sDuvbZ4ZBuH9gQ2cMhhxYyHc0jDhXSk98kHXG5lE7Rk7BQgfBonuD?=
 =?us-ascii?Q?Kum6b8mzfkfGOaOvDSbE+c7atxphV6/w3+BhWDpS+V9cWRZT19UaId9PLE92?=
 =?us-ascii?Q?erhMizv3CfB+t6cfIaFDx9oaXZjo0dXhavmO+yZu1+3iQX+E5S0245H+6Se4?=
 =?us-ascii?Q?tDcVdLTOFAfdHhsr/bfG0ebV+RHSwlOy7ElY4GUdmig5KbOb3ZT+czRkQKki?=
 =?us-ascii?Q?J1fiexqSwgnmGip3kzBntvr7DVGpy2koW/MAL6AKywXKi+jIRN26Jotx1Sjp?=
 =?us-ascii?Q?t33iIxtOuOerQlQ49OKNxdFa1JoVktLWpbZ5gkQUDXK9669afUoedw1RzJ/p?=
 =?us-ascii?Q?9V1EblxKSywcuFjOm+sJgUeJxk+4l57FEeVv60IRhChhYsel42vRm+a/x/lv?=
 =?us-ascii?Q?sACr2vfeOEPt7pKQtKmbW+6yha7Y/dhZbl25q4Juu62He92ZBoLTAPabAzao?=
 =?us-ascii?Q?edUXnBJh+ZannB3x+OIJoKcvkapMHsByaNCfYyUIoXQXuvCCi/4bzUPKx1m/?=
 =?us-ascii?Q?itvsf1yB8cshWXtBEkyuwQc/gaNH2ftM1nCwC8L+kL7Yy/1LAMqYITo5oohm?=
 =?us-ascii?Q?PeHluJB7pGctxLeWKtzEVa57MMkQ8A8CPvRpjujDBRnI/kr6TG8oFlg2LmVw?=
 =?us-ascii?Q?mCzPSy+LTfVDK/Zd/qqlj2RFQt+/DmfAX7Qr2UDCGOzWpXCDO7XD+WoZmLF6?=
 =?us-ascii?Q?ot2b/iuVYhgFLi+yWJGJHKuV8Ci7tYkKp1j5ADJ7jBD+Z8kwcUSnW32oYtBj?=
 =?us-ascii?Q?PvoLuS9Estu8Nr8F47yZFcBTR+OiynIvQVnVhyo8QKOo+aBExC749rYW7thU?=
 =?us-ascii?Q?Bo+MPqcorQfbVUQYwTVbpsylfOGRAr2ZBArWHT+o/Vay5c0q2O1/8G4GkhoJ?=
 =?us-ascii?Q?KoXoOD42xW3Hsw4TD3XL/boHzA6R1zNm+1uF87Gn+habaf1DfUwugIb5lzjS?=
 =?us-ascii?Q?mokhzuZaWH4v++57AIIjfyg6OIkYjYOkNkUg20nSiD9Uv26y6U9fmXWEtUYB?=
 =?us-ascii?Q?1rKwMZ2RAFvaDFVzEByxUi5XHE0Q2IFK6emBmgRVVr4Ag1LyfKWTqyR+Z6XQ?=
 =?us-ascii?Q?w/q3jLqvD4PjlKDF/La8PpMU1Yn7UnXGGj9KggdNimSuuW94YTiTpMlOhvt3?=
 =?us-ascii?Q?r9SIZ1EcZ+LBcEICcrg0Mjc/4hP2zFt+UuHUnpRxg2LE91RNxbhEo42sSW+T?=
 =?us-ascii?Q?IjNrV4ydHCEJwQjsIVNxj5z/aWwh2Q6MBnD9RhgmT7KoNx5o3dn3qCzzpF2u?=
 =?us-ascii?Q?g3OIMZ7S4f8fYqGUsVS39MBIcVV/bekhhV4Q0FA8/JQ8LJNjbcjkNylqF17P?=
 =?us-ascii?Q?Ns+95uzJWQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b290e74-dd76-4dc4-7cd2-08de4b150931
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 22:11:25.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ScpPF2LlVTNFoJo8oHie3Aci/jusOeH5ATyZAEkZgHEaUJdJzZGEs8XHU5h8yjfn0CLbFRWLydr7W6D909svg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7242

The RCU nocb logic is complex, with duplicate code patterns scattered
across multiple functions. This series is a small refactor to make the
bypass-list code easier to follow. In the future, I am planning to do more
refactors of this code.

This series is based on top of the earlier -next series I had sent:
https://lore.kernel.org/all/20260101163417.1065705-1-joelagnelf@nvidia.com/

There is no urgency with this particular series. It is OK for v7.1 as well.

Testing:
  I ran rcutorture on this series plus the earlier -next submissions for
  16 hours on all RCU NOCB configs (TREE01, TREE05, TREE08). All scenarios
  passed.

The git tree with all patches can be found at:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (tag: rcu-nocb-cleanup-v1-20260103)

Joel Fernandes (3):
  rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
  rcu/nocb: Consolidate rcu_nocb_cpu_offload/deoffload functions
  rcu/nocb: Extract nocb_bypass_needs_flush() to reduce duplication

 kernel/rcu/tree_nocb.h | 143 +++++++++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 57 deletions(-)


base-commit: a02abdb7c34af5364e6243276b8ba1dc50972ffe
--
2.34.1

