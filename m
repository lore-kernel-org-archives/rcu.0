Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28555188727;
	Sat, 28 Sep 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531636; cv=none; b=lyHo+VsCuqv77BdY+MwUoroycdIaDwGdHPIMK5hJtCB3sE8gVnCY4eVp0zaK33oYj8G96Q4mpxFjhXfuNrCFc/it7rihi7QLsr2737a/SkrJtsCHYUolveuenw3eJXRU2emfoNxSFxyMkeJZf9rcMpG88ANli/jMKRqgHnpAQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531636; c=relaxed/simple;
	bh=AXylBb84Gi4ZLn9QbdSfWz1bezylh9IXiXx7KEkTzjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PB3GtbhR3Qj0PpBweLio+W9jlxqw9h0KFSgzPvIGcYcYu9MCAoXTJEjggEowB0GC1PSEzG/ROpnQkvlPc0H/O+nOzQhDn0ejcD6dApqN0oAchnikLsXsDJ/De1LDmxR6aAHfomMG3Mcsp0iuC/Scu+SJ3yGp682QIvbMmPXOxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=q/B77HSh; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="q/B77HSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727531631;
	bh=AXylBb84Gi4ZLn9QbdSfWz1bezylh9IXiXx7KEkTzjs=;
	h=From:To:Cc:Subject:Date:From;
	b=q/B77HShFdxTc/U7T2Q1s8y3U5mDSC/aRDqgMJJThc8YVccivPQM/rgth9IwRaxeH
	 q44c9RUC6wckcPus36YKTqUj1+84amth0u/vDFEvEQ0i0txruTuKX+tWl5zQpyUmJN
	 OJMnFaAtEfrx7mGTm8fj3CL1xhf60KrptOGMvyMB0hretwuZvD1wx03r/DMWurATlj
	 4XxAH5Xr44Pp7louBaDrFRsxAym3fVPLVypG5LFyDLOkGXPcftZJtVB/F601kzYnxd
	 LNm7L2NJlaPKAiykaompuGpW35Qmu3DuVs5TkzZZoDOhU2wHjHNU+7DVOemv/7SU+z
	 QvayCYLOM8vnA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG82754zDz1bpl;
	Sat, 28 Sep 2024 09:53:51 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [PATCH 0/2] Introduce ptr_eq() to preserve address dependency
Date: Sat, 28 Sep 2024 09:51:26 -0400
Message-Id: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ptr_eq() to compare two addresses while preserving the address
dependencies for later use of the address. It should be used when
comparing an address returned by rcu_dereference().

Thanks,

Mathieu

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev

Mathieu Desnoyers (2):
  compiler.h: Introduce ptr_eq() to preserve address dependency
  Documentation: RCU: Refer to ptr_eq()

 Documentation/RCU/rcu_dereference.rst | 34 ++++++++++++---
 include/linux/compiler.h              | 62 +++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 5 deletions(-)

-- 
2.39.2
