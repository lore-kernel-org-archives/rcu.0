Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F8280035;
	Mon, 16 Feb 2026 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244425; cv=none; b=TsMgXtNbXf+EXONQL1ORLCyuXgV26WZIoV8spTKKx3RIDu0qo9JSLpvsXKGeIfuA6FPh8kNdxf75rpPHme3QtEWwxqrUUiskHHqfgPPPxWimC2WNChNGqWJm4Qup/34D3hLMKyFz9dYuhhnV3BheO08pto6hEDW7BOrWCJ+D+kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244425; c=relaxed/simple;
	bh=CM6Ir7lCfpnrtsmdf3HYlHe9Drd/fFGQ9vZ6oXs5tuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrxisgSgjhRzRVDo31GQqq+UYV+A3upYXLx5ytKYaJ0sbTAKnzuvkeDqU1tNojcedoHQCwG10DwWmLF/XkEi1w8yYA3u1TRepNvrZJf5rEKMxBhp0oCx+4LdEJ7E9LIFjseQDPJCWeaz7cRgPyyxnYNeYsG1hDbFTjTxrjfXpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Us6i4y1Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Us6i4y1Q"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FMoxgK3759249;
	Mon, 16 Feb 2026 12:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nOgL6k1PpuPhiihbiisG3TipFAKfpyXXRETnIC+wy
	MQ=; b=Us6i4y1QJNZ2xwAEMSv811PwF7EuG4yVdxVc7NbSlMsYVvT59MENV+c4d
	j60Re7CkxGaZu/1lxD21CIsnhiF2qWGpXDcckA+LzHpYYSPV2qZGs7GpTp6cEtXT
	S5pXlIoo7o7DXBhBwIZgE/qgzvK0QMyVml8Sgf/3LzpLa0OxbRcQ8JRUruO4iZYl
	xPkMJvcLFRg3RWL2ZzAelyBkkAdfb1OcAUHrvr7XrO59iSOZDDHkFviYSD/K6zim
	unWJ6ba2AmS1mcmQ27aQYLSME4eH8XURp33W8AQ0JM7U3LSDBUPZ5di51L6amr2V
	Pxio3QVKgPLpIYTYQgAFgqoucyZzA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj7338-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:19:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8YxHl002888;
	Mon, 16 Feb 2026 12:19:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj53g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 12:19:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GCJqFx53477834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 12:19:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F20820049;
	Mon, 16 Feb 2026 12:19:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9387320040;
	Mon, 16 Feb 2026 12:19:46 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.220.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 12:19:46 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v2 0/2] cpuhp: Improve SMT switch time via lock batching and RCU expedition
Date: Mon, 16 Feb 2026 17:49:26 +0530
Message-ID: <20260216121927.489062-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ObmSQ4GJemKB6XVluon7KYioobrcaMOH
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=69930b6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=1NBuismN5kLE1Ry4-C0A:9 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEwMyBTYWx0ZWRfX5m38+778qnHJ
 ti4nSI5WPBlnYHa2FNpmuChDaL13jzAF417YL6p79Cc9dbC6eF7AaNnOOKgUmGgwhKgNa57Ecol
 4eJ59XSUblupGmtoz6Wfa1dF5rUioUpDG0ayJqDt/ZmWsB4eY5Fz43zP3968lFI6TUw58Whetae
 dXyyokeqm0sOu4JeEKCdJGXf1PJtnyohvdpwIVkpITBjhfplktBH5GiBTv2uO09Fzxs9NIBA1pW
 +z13ngMb9bOVoDFenOKBBevchil+qD0vHmPY9kbxCGGquNmfJtJCItlhFKO1r2MP9FAVv46pAC7
 gmRySRQTKYsleO9o1zXOMNJTqlW9dtuCLQsq+PH6f+lIZfpk173NSqH2wkP+atR6Q7XPLES51Sw
 smyyYBq6C8/46jwXNfvgRN8k5geR5TQSk6ynTCKWG9sKKTQNbyxAGU2lPwch5K3h0lovhcMts2V
 zXoXTzXTx1Bsc1XyTwA==
X-Proofpoint-GUID: LVwuMVgmE8nGRSYRu0R-n8TCm0ZQ53qZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160103

On large systems with high core counts, toggling SMT modes via sysfs
(/sys/devices/system/cpu/smt/control) incurs significant latency. For
instance, on ~2000 CPUs, switching SMT modes can take close to an hour
as the system hotplugs each hardware thread individually. This series
reduces this time to minutes.

Analysis of the hotplug path [1] identifies synchronize_rcu() as the
primary bottleneck. During a bulk SMT switch, the kernel repeatedly
enters RCU grace periods for each CPU being brought online or offline.

This series optimizes the SMT transition in two ways:

1. Lock Batching [1]: Instead of repeatedly acquiring and releasing the CPU
hotplug write lock for every individual CPU, we now hold cpus_write_lock
across the entire SMT toggle operation.

2. Expedite RCU grace period [2]: It utilizes rcu_expedite_gp() to force
expedite grace periods specifically for the duration of the SMT switch.
The trade-off is justified here to prevent the administrative task of
SMT switching from stalling for an unacceptable duration on large
systems. 

v1: https://lore.kernel.org/all/20260112094332.66006-2-vishalc@linux.ibm.com/

[1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
[2] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/

Vishal Chourasia (2):
  cpuhp: Optimize SMT switch operation by batching lock acquisition
  cpuhp: Expedite RCU grace periods during SMT operations

 include/linux/rcupdate.h |  3 ++
 kernel/cpu.c             | 77 +++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 20 deletions(-)

-- 
2.53.0

