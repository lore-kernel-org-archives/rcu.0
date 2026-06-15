Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508D1991CB;
	Mon, 15 Jun 2026 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497583; cv=none; b=ib/5ZaAY3VDsA4GZi5Jai+aMH4jju/6nK2X6WyoGccG2SZ/+VBhD43noaHD9CSsurmDMrhJ3//k0Nd3vClgVSvR1UqAGQTAStui6zRuCv9Xp6d7tKQJ6gQRgcHwr6MCabWOuxdBQLSxpIgagoVvwS4bBR/VHHWyArPsmQWN/0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497583; c=relaxed/simple;
	bh=mPpndHZDmcce/VQhaz3ExaqUzu/Wzy920UkOiduw8w0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOO9I67Gn0I8YkWB+Uwo1Xe4GsqyO9UdHOmwzn3EFQXNrMzibfc2q5ZWVUkJYMZTI1XDSMC4Qp54VpAuz6WWdFzyShIbSXtABpkOWA16CFx/pus+p1F9u2FfB57Ys6d3k8+oEuw6pGIV7ldRVqR3pP51+HcUnqKnE/u1+iTxKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dZMuurks; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dZMuurks"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1nBBs934153;
	Mon, 15 Jun 2026 04:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zRJcwzExtQEA2e/AqZAomW7jv+Sh9ux5hUopPU5r0
	Zw=; b=dZMuurks0Ho7sEF30o4l+fNcohRGwZzd9a6CNXLKz6xPnyE5aXZFa3fy1
	hi/WnUYg/LgEThwNPoTuPMynsHkznJAG9uPhtNlKXJ6q2Kpy35u1m7a1SZMN4Sz0
	ZD8M+2iRaMJZSVyJ4kvcX37DCF3TwdzfYzdj6N+3kLuaBYnS6pN3kVnd/4E0Jj0r
	AOMmC/HlvFsbAZdiZ4M3HzOi07KNu+jIi85PZ7mPp3ff9meMi2qMjkgsRMt6Qf1q
	hnNW3KWY3MufyGMxueifRPUiqgSrLvfbNUW/yyWWH7qAGneFYT7fQ229hSxfkXFZ
	dQiXhyHQN3Qlk3a4YY8hRAKVOjcDQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkxs05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 04:25:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F4JbUw032587;
	Mon, 15 Jun 2026 04:25:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpw3nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 04:25:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F4PZpx35324196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 04:25:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF16A2004B;
	Mon, 15 Jun 2026 04:25:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD54A20040;
	Mon, 15 Jun 2026 04:25:29 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.124.215.27])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 04:25:29 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, aboorvad@linux.ibm.com
Cc: peterz@infradead.org, boqun.feng@gmail.com, frederic@kernel.org,
        joelagnelf@nvidia.com, josh@joshtriplett.org,
        neeraj.upadhyay@kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        srikar@linux.ibm.com, sshegde@linux.ibm.com, tglx@linutronix.de,
        urezki@gmail.com, samir@linux.ibm.com, vishalc@linux.ibm.com
Subject: [PATCH v5 0/1] cpuhp: Expedite RCU when toggling system-wide SMT mode
Date: Mon, 15 Jun 2026 09:55:14 +0530
Message-ID: <20260615042514.694993-2-vishalc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0MSBTYWx0ZWRfX9RiroZb0XPHi
 BBTFBD/5q9pl8bSS+dAYOJwN3TqR8UIMg/r/VcAMknaQMCrhzOShvKAFLdSFYdfk0pCoY2WxAxf
 8XiWKOUwqjaIYHXpu0c0+FycMCuOpVo=
X-Proofpoint-GUID: lPSb6hZx0e1gySS-VN4udzEXC-ieWkKZ
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2f7ec4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=WsHKUha7AAAA:8
 a=Ikd4Dj_1AAAA:8 a=qw6ujEletJEoEWBefboA:9 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0MSBTYWx0ZWRfX3axcuCMboxFL
 aw94kqa1NQTEdiEEuvGky/KTUVw+/7+RVzchS7BEHNWCizfQ9PldF1W5n0Elz1ARjAgPgD9BIKX
 qrAQ5qaWACWkOrzWUfOad/HS6dP/frQVdYz3KfSD0JD1dks8xQeVCjKIgtAdmkiN4pfq0Hc0yEN
 iTnSbuwKA2FVvmvPJr1/v7u864lODGNE1+OujiY1AnNrzhnXJO/GtMW6q2MUUHzIip6nQhMQGWT
 edPaxBqn8Myli91bnbxrrMqAdnvNRosHkwKqjdCsojktQ2bibb1JezaS3hl4pgMAqwdfhv+9bEh
 zzGHzMeVyN3qItvxfKZBgOKRoTaG2SBo+NA9mO/OomDudYFdUlOraXaQgU6KL1RVGj7FcT+eGgL
 r0yjuZChPp/q/grBCFnnKOTjafk13OmIA1e+5bc5harHQvFm8i7sTZ37wgbJ8MW8D5no+9wBH0z
 PQnYnZEalhk2UDlWEMg==
X-Proofpoint-ORIG-GUID: LD8qRo5hbHV8-gb8n8m6eKW375tE2lXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150041

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

v4 -> v5: collected tags

Vishal Chourasia (1):
  cpuhp: Expedite RCU when toggling system-wide SMT mode

 include/linux/rcupdate.h | 8 ++++++++
 kernel/cpu.c             | 4 ++++
 kernel/rcu/rcu.h         | 4 ----
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.54.0

