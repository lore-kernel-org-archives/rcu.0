Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157032D43C;
	Thu,  7 May 2026 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778132513; cv=none; b=qojTLNCmBXWDE08zEMEWRPiTrjd+LCpfazBB1DTTuqTfIA9k3BkojFlLrAWOwR8OkpKKT/K9weCvZjB+o69HCbosO4cU0QNrGvq0oJoKDHJ42lcfhnKIX/hniQHguv48whY5hcixxWeqIT92v4hwHldvC1ZkexczZCDV+ngr1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778132513; c=relaxed/simple;
	bh=f7F6vkhPKaq5Fb0KFqHWnrPR15LCrY6bZLZMi9Aspa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8OR8a5X7KMeeWUni4DOzl8Q8wK1VxeLUDnxF7+YEOtdR0jGXSRrcOua6VeFx9g5OONUlAGbYk0XrC+vFLs6lVC9sbJd4ZXfIjqKWE0jmDqljGbjBvapB44WMQ3nMZ8rZzxh4GN3KGHJc4tOcX3dIr0KwmzzdeGt/RR/h1KdCLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VMjLVqej; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VMjLVqej"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646HX5GS1117863;
	Thu, 7 May 2026 05:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NRI/PzEGVU1oxagJbSr4PzGNQZ7RIKp9hScQF252H
	Lk=; b=VMjLVqejxlfKFJIPApddvuNen6Wns5SSyM8PSA0IZ1jetbNU3882nB0JU
	a6sobGzRIwKZYaO9GMOpawO6Xs/BvMiAvjWVZkLWUMWSEyl76vl2W/t1szf8EVef
	C8phrdAwB8czbpiG38XKh4AuivxFcxLV1RoHwjiP2Wy89NNwN28pqeUZhVEijx2t
	A5VWYLY08T1eIj3ZIZjE0cDO6mGrrQzx1HxIM7RjL9mC8Rhw1BBSoGOZUSBmmjKt
	MMDXjoEEoLWQIj0boL3S7rUABxL7SgEUZUVpOmPv/rb20pHoxE6ko/G6gzAfMDao
	SdPPU9+h3YSoHQWcpvxf0VrdBgXUA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4v9eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:39:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6475dYOK004771;
	Thu, 7 May 2026 05:39:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw9pbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 05:39:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6475dr6646072146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 05:39:53 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E0120040;
	Thu,  7 May 2026 05:39:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D5DE20043;
	Thu,  7 May 2026 05:39:49 +0000 (GMT)
Received: from vishalc-ibm.bl1-in.ibm.com (unknown [9.123.2.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 05:39:49 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: peterz@infradead.org, aboorvad@linux.ibm.com
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
        tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
        vishalc@linux.ibm.com
Subject: [PATCH v4 0/1] cpuhp: Expedite RCU when toggling system-wide SMT mode
Date: Thu,  7 May 2026 11:09:27 +0530
Message-ID: <20260507053928.2975867-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA1MiBTYWx0ZWRfX6rzBQVhqtFir
 778CJZsK/ur3yf88MMQ0RcAF5uLRM0a+d4chpyvXpUNKKjkrQgqzeJu/bsE4Y4Mt5493CUb8KIm
 WzA3ktwC4mTUsq5E6vZx80h8UqkJ9FeajPpKXENoondMv32td3+o4S7FGtp6OoIPDiax1TyUS13
 oOpzCT/Qw0ASnwABHNkHLew11ccylNVjUFG82qQ8AmcMtvoF+X/HvcSr7U1ebqbXx4ZNdx7Z7ws
 zE+INHfyYKBNmiIiH4ZTIm3aiIJAilRU5tciBZeNT1N0CBCWxJvHFLpkSsmF+FGdvbIy/YoSbbO
 KY1tPlssXOUMwt4gIBMArrjBmkIZmQf/R8PJDKgztLJOY0zsC2s1kx44VttCT/bltYQJPYyXfnQ
 e0ph+QP93ElDQOiD6eJDXcNBEbI8RhU4fPLJX9InvD2O4obscs9rDDbIxFR0uTrT5/ECtpgCNuc
 TyTlEwUNVy95HFejHnA==
X-Proofpoint-ORIG-GUID: wKRcoqPOvFg5igEC8INH7PxB1MykMVlq
X-Proofpoint-GUID: eLwDnYMtAlw96EU_ZaI7U_q7O7bFx8J8
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fc25ae cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=Ikd4Dj_1AAAA:8 a=qw6ujEletJEoEWBefboA:9 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070052

Hello All,

SMT mode switch operation on a large CPU count system takes close to an
hour to complete. Initial debugging root caused the delay to the CPU
hotplug subsystem being blocked on numerous synchronize_rcu() calls.
Simply enabling system-wide RCU expediting reduced the switch time to
5-6 minutes. Since then, different approaches have been explored, of
which some had their own side effects and others didn't work as
expected.

Approaches explored:

1. Expedited individual CPU hotplug operations by wrapping
_cpu_up()/_cpu_down() with rcu_expedite_gp()/rcu_unexpedite_gp() [0].
Peter suggested expediting only when SMT switch is triggered via the
sysfs control interface, not for individual hotplug operations [1].

2. Replacing synchronize_rcu() calls in the CPU hotplug codepath with
their expedited variants. This is not viable because one
synchronize_rcu() is invoked inside cpus_write_lock(), which is shared
with other kernel subsystems [5].

3. Hoisting cpus_write_lock() to be taken once for the entire SMT switch
operation instead of per-CPU [3][4]. On large systems where the SMT
switch can still take 5-6 minutes, holding the lock for that duration
causes hung task splats and starves other subsystems depending on the
read lock.

4. Peter has also suggested using rcu_sync_{enter|exit}() which as is
doesn't help as is, but can be paired the approach 2 from above.

Current approach: expedite RCU grace periods around the SMT switch
operation in the sysfs control interface path, per Peter's suggestion
[1], with Aboorva's analysis confirming synchronize_rcu() as the
bottleneck [2].

[0] https://lore.kernel.org/all/20260218083915.660252-2-vishalc@linux.ibm.com
[1] https://lore.kernel.org/all/20260113090153.GS830755@noisy.programming.kicks-ass.net/
[2] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
[3] https://lore.kernel.org/all/20260119114333.GI1890602@noisy.programming.kicks-ass.net/
[4] https://lore.kernel.org/all/ba470918-0ad9-4548-9161-826948462f73@linux.ibm.com/
[5] https://lore.kernel.org/all/804E7B47-F515-4592-B12E-84AD251EB07D@nvidia.com/
[6] https://lore.kernel.org/all/e2cca734-9191-4073-ba9d-936014498645@linux.ibm.com/

Vishal Chourasia (1):
  cpuhp: Expedite RCU when toggling system-wide SMT mode

 include/linux/rcupdate.h | 8 ++++++++
 kernel/cpu.c             | 4 ++++
 kernel/rcu/rcu.h         | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.54.0

