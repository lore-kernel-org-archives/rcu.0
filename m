Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129072D9EE4;
	Wed, 18 Feb 2026 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771404035; cv=none; b=Y/uWk+Kf9KhE6hbV3H8Uasf0EKWM78/8XH/fvBwvjDhO9o1vlwVN0sa9RSsEgah9BhNksfcz7iuw1EotoVYIpZfdSENNrjNd2MX54mElvIr0OuAdQF6kjKErFZcTvtptt4xyg5o/yiPFjF/EGF693Q3t53FJytNBQakgYC52C+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771404035; c=relaxed/simple;
	bh=r8kq09KVs06A//18jR37nuYdAGxqv/sE6izGhlDD0SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgkPmBdd3aw7sWCtFbgUdow7vcqMbgKv60JIIIvaABEVQ2GzQFhDU/FksJEm8NKr/SU4e7oRbvnMRjbDW0clukxkPxshU3JrjR1W9LEj5SqPZpEpqIO/NqZTW9DkZ0KB6Wdhmvs6ZO+c+6D0xxR2ik0DYcllT6d4NXVHOIpyah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qm/zMHzT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qm/zMHzT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I3tAfh2392296;
	Wed, 18 Feb 2026 08:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wv+r1i1tXzJ2sEDlFhnRqYnVAzdDnFRCkdeWe+Nzv
	rA=; b=Qm/zMHzTCW4RfDXFCUzjeZtFoz32WdPWKpfDIaHhCyjEUFTC1vwH+qcTf
	i1VpBWD5a9ZgdlfPk1tQrKdgT2XX39J7DpExDTpOkeP21CivpjutNcorH3FCLAVx
	NtPEfXHXH3GPZJimFuCskpPW6V53SqWaTl/Nfep5lbYQzPbFI+qjSGBCekqu1I6T
	Kuvd0BcinniDVH9HqkbwhS2oPEkHu2lq5ZAp14hpHW2BOj+Ami/Sqy5+93bGFjw2
	8wboSjyvCiILnyLFPU0j2X2BF9Kx6lLud0zO8FfJxI93LmpLKGzrAssPmpokiDe5
	HFWqShTLaJtVg2TrHHawS12OAqZtg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s0au0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:40:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61I8Ohw4011916;
	Wed, 18 Feb 2026 08:40:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb26y455-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 08:40:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61I8duiW13828448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 08:39:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE90220040;
	Wed, 18 Feb 2026 08:39:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A8220043;
	Wed, 18 Feb 2026 08:39:52 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.221.53])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 08:39:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v3 0/2] cpuhp: Improve SMT switch time via lock batching and RCU expedition
Date: Wed, 18 Feb 2026 14:09:14 +0530
Message-ID: <20260218083915.660252-2-vishalc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=69957ae2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=QyXUC8HyAAAA:8 a=ROf8l5uNrF41CHCozSMA:9 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: LseL6TkbRDoQghZybbZZVXQgnVzR9-Mk
X-Proofpoint-ORIG-GUID: gaflu6Eqs74Dn7kNO3Ep8BbnzbNOKmQb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA3NSBTYWx0ZWRfX+Pu1aMWI4QS9
 2lv/OLsu0w9slBiaZomZN52PvchyIUhIBZixZ0HHg+MbOeL6FG7hZj/h0IGUzoYTZLjW9WWBse/
 GTrFmvpykJRARSaDnHpnEKuj4yYwGPnhSYGhDWtq1b4InHbz0XN2NraEJeOV3LU8b9NhQZl53hJ
 SKIN2vok0B0NORkBLgKmkDIIP6R6bf2jnMG45DKovxZQ5hHFdC/qpVnS+axgOrJhT1nF5A9nk/e
 6pltQ7glgyOtuBXOX9zBptZSW+4u9QWEh1CS6wrkByDAqA1U6P3vOU6Q8Ysq5x6hBl661C6DIiW
 tgQFC/XQPMIvH8YkhTVs2W0gy8iD2JACMaG5VsW1pzwTmfE3PkPipU8EBLsE1/usQQP2xbVOuTb
 0Cobt+++W9gOTuYURHg+n/XtzNjqhPaMBIbUrM8mqAYtzIwkAQh1H349rFl6ZMMbUCZ2ihd9QyX
 MYueG1X34Ft9+vAceiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_04,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180075

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

Changes since v1
Link: https://lore.kernel.org/all/20260112094332.66006-2-vishalc@linux.ibm.com/
Expedite system-wide synchronize_rcu only when SMT switch operation are
triggered via /sys/devices/system/cpu/smt/control interface.

Changes since v2
Link: https://lore.kernel.org/all/20260216121927.489062-2-vishalc@linux.ibm.com/
Move the declaration of rcu_[un]expedite_gp() to
include/linux/rcupdate.h. Thanks Shrikanth for sharing the fix and
kernel test robot for finding the issue. [3]

[1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
[2] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
[3] https://lore.kernel.org/all/202602170049.WQD7Wcuj-lkp@intel.com/

Vishal Chourasia (2):
  cpuhp: Optimize SMT switch operation by batching lock acquisition
  cpuhp: Expedite RCU grace periods during SMT operations

 include/linux/rcupdate.h |  8 +++++
 kernel/cpu.c             | 76 +++++++++++++++++++++++++++++-----------
 kernel/rcu/rcu.h         |  4 ---
 3 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.53.0

