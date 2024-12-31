Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBC1AA791;
	Tue, 31 Dec 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735664845; cv=none; b=gJ5oJriBKMR+YgqEfQI7Odvl9+0XJOXj1jMN/rfBytAsnY2fqWY39MIomp9kguRv98ouL97SQiEnrWDtT8PajIOWALVLDUJqHgfHCnBTXqrH+6ILtKMLZbuUIb0XPg91IWmkUDCZdKoHL6nnw9Bi/+DeGUBggG8RGJMg0uRMDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735664845; c=relaxed/simple;
	bh=RqDpuHEavPYVvgs33Vl7b6tf9PzspwVQK0nIPaZde5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ilX9JZiIsfLEmwEEzJIHiqBY6tOtZ0FgeCaYuHxtOkWknk9tgMumiR8BpCKpoOYRgSoLs63TvRJHxmE4CUW+c/gjRWGxtXhjn0AnhDr8Grr7GCyvynY0DEq+JnqVrO2SiVZ0znIOQxw2ewSooGzx99PPCcAmTJsjkJo7cdOOXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRyDkblu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRyDkblu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F39C4CEDC;
	Tue, 31 Dec 2024 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735664844;
	bh=RqDpuHEavPYVvgs33Vl7b6tf9PzspwVQK0nIPaZde5c=;
	h=From:To:Cc:Subject:Date:From;
	b=PRyDkbluqiXiTGKXTcWaySo4L/6hZYVLHfEX4CAjBnCndFVM46rBKwq2crNZ4ARZ3
	 eEotbdgHAUZRP2KpzUQVweDcWzsWgzbzuuGQ5lFy0sSH6YnPDa6RqdEqYcLVK9YApa
	 u8mXlfL5RiQMe0OjwreyC2aWB7mSXAQBMVsTi2v1L2xkRSZtARYj+Pu9TjWgltyulD
	 SI4mt7TX0lCogjJyiAcq6QoeFWNtlAzWKNkW/ZdRoFaZG4wGrBPQx33x7/CJdi1FW3
	 p9XQnaMZ1g+DRqgHh8XXdaCcIbomaVUXqFok5Kmzz8KDo+k0RheklhlpbNIV4AcEwb
	 IazffYV+QYHew==
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
Subject: [PATCH 0/3 v3] hrtimer: Fix timers queued locally from offline CPUs
Date: Tue, 31 Dec 2024 18:07:09 +0100
Message-ID: <20241231170712.149394-1-frederic@kernel.org>
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

Changes since v2:

* Fix and add some tags
* Fix extra newlines

Frederic Weisbecker (3):
  hrtimers: Force migrate away hrtimers queued after
    CPUHP_AP_HRTIMERS_DYING
  rcu: Remove swake_up_one_online() bandaid
  Revert "rcu/nocb: Fix rcuog wake-up from offline softirq"

 include/linux/hrtimer_defs.h |  1 +
 kernel/rcu/tree.c            | 34 +----------------------
 kernel/rcu/tree_exp.h        |  2 +-
 kernel/rcu/tree_nocb.h       | 10 ++-----
 kernel/time/hrtimer.c        | 53 +++++++++++++++++++++++++++++++++---
 5 files changed, 54 insertions(+), 46 deletions(-)

-- 
2.46.0

