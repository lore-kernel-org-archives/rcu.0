Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A813B58F;
	Wed, 18 Dec 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540617; cv=none; b=Llef6x2V3EHfIU3MAqJy8wcodkv0+QW0477WQLZe6Y8fCULIN0jgzAOju4pfrCUixQ+u9Ce4mKJKP7X29Bf+ciAsFxBflkCALHuG8rSXYdLR+HXOcd5AyW9FALWXLU4pnXPMpOfdk6szmdFzq4s8Kd7TZn41XYLyAW7ovTf/G1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540617; c=relaxed/simple;
	bh=9B7cQxHHWrqNqvr1GaRUF78d1JfHtgi/Z7yzNkFGNpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rxcn41KxGSYkaRyKVxU8Lj2YiRNd+UKHJUxEKLYDgLiH5s5MN9ZDC7KHYxTD9KQH/YqQapUFo0EKctZYZe99T4ABYHFz59HFJ+GyhK2xFEEeoq7hVf5pwYqL+8+xx9fWtDokTU5WTOfNdD7rhBB3KmtDesxKeK5vjgtzt/otX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2yn/xeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2yn/xeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD19C4CED0;
	Wed, 18 Dec 2024 16:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734540616;
	bh=9B7cQxHHWrqNqvr1GaRUF78d1JfHtgi/Z7yzNkFGNpo=;
	h=From:To:Cc:Subject:Date:From;
	b=d2yn/xegJLJ9jPXoyRsbLF0HmRTHEgdL+Vt7SxZY7LdigHFW6/vm/yzazpJd4YNa6
	 fFKFe7MxRBH6GqqyGvcObe96eErJUDhzURSlU+41mZhSrSQAx3gOTtPLKVRAMkgfe+
	 PWstIT+6zAYHyRoCsXOJbtvhJBiTq7VzipE/+BHuh4Op5yvWTOnswjOWYiz07rmsjy
	 /OFXLHq8kjHIHJyp5R85s6oQiba5cQi+cyMcQkhWzYP6aFM4WDkaDzrDe4HCOu8bti
	 5vsYel3unkz4Tr9EHZW/fsQzZ5iQinh5eHNo/flrXMCI0hoNJIWmQZfip35VhjD+dk
	 fOGzP6hOvBAmg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	vlad.wing@gmail.com,
	rcu@vger.kernel.org,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	neeraj.upadhyay@amd.com,
	urezki@gmail.com,
	qiang.zhang1211@gmail.com,
	Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 0/3] hrtimer: Fix timers queued locally from offline CPUs
Date: Wed, 18 Dec 2024 17:50:05 +0100
Message-ID: <20241218165008.37820-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
was introduced to fix stalls with scheduler bandwidth timers getting
migrated while some kthreads handling CPU hotplug rely on bandwidth.

However this has introduced several other issues which used to be
confined to RCU. But not anymore as it is spreading to hotplug code
itself (https://lore.kernel.org/all/20241213203739.1519801-1-usamaarif642@gmail.com/)

Instead of introducing yet another new hackery, fix the problem in
hrtimers for everyone.

Frederic Weisbecker (3):
  hrtimers: Force migrate away hrtimers queued after
    CPUHP_AP_HRTIMERS_DYING
  rcu: Remove swake_up_one_online() bandaid
  Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

 include/linux/hrtimer_defs.h |  1 +
 kernel/rcu/tree.c            | 34 +-------------------
 kernel/rcu/tree_exp.h        |  2 +-
 kernel/rcu/tree_nocb.h       | 10 ++----
 kernel/time/hrtimer.c        | 60 +++++++++++++++++++++++++++++++-----
 5 files changed, 58 insertions(+), 49 deletions(-)

-- 
2.46.0

