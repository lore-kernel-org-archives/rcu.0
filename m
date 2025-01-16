Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811414AD2B;
	Thu, 16 Jan 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057938; cv=none; b=MH85hWXuPkxyRY7Yr1l4q5tQqF7P1RtMoEj0OHElG3vtbOgVs1Ye/VQJquFFk8NwpBuUQOT6x992z+WEbFrvNSzieee2w0C8260/A6q/kcZ3lskhnqF5xldq3Ox4psBHQgKjObFNPB5AAAlmmAoox6iDDPSjKT2MeU0pf4/54bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057938; c=relaxed/simple;
	bh=bE8B1j8ThaVrcRuMRy2dRH06ILF/sCg5FujXLSvdslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bAyG0Kw+TMR/KJQxSFTg3ZJ4ZGzuyPg5uw6h6P8lGA/8FAzxbvkA6EkMz4MM1fgi5CIA+cX7x344DMaDj0m1KQ0S4hpYlEHwq8BPssTUv4G7DlMF+jIe6WJfNoGJChKKx/wGYhsPgX+fxgKEjDhiqJ0e9yTPR2aQjLMw+TrazVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdtdgrIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdtdgrIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E224C4CED6;
	Thu, 16 Jan 2025 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057937;
	bh=bE8B1j8ThaVrcRuMRy2dRH06ILF/sCg5FujXLSvdslQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=fdtdgrIFR74pWfJcW8k8hQUh3WfNqgMQrQwKGrUtGEGvLVu/hcy3CoX+0ON/K2wvk
	 LOmqVORiVsCa0sQhlNkxsrSk5u2WBoPpMgOoK/qkoFcCTlyI4IkHT1dnDwzA2dt7Bz
	 PdiyDQCiQl01OQflg7XpA4R1MSlpniB9pFfvit93enC8egVW5JcuYkozN+ldcqHe6R
	 QZ/IEWlJc5AgeJzwlrFQRyJT8d4X+3JL3L79+SmgCUWRe0SwgKJRNl9LlZhiRQcZ3c
	 KuZKYfHY0XFv5rwyg+Co8CspCZXddmAfwxaHw+oHWcBC1qh5bbO7sglcVaqh4qfrx1
	 KXK8ZiFh7LZrQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1CF2DCE10F9; Thu, 16 Jan 2025 12:05:37 -0800 (PST)
Date: Thu, 16 Jan 2025 12:05:37 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/5] Miscellaneous fixes
Message-ID: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains miscellaneous fixes:

1.	Split rcu_report_exp_cpu_mult() mask parameter and use for
	tracing.

2.	Remove READ_ONCE() for rdp->gpwrap access in __note_gp_changes(),
	courtesy of Zilin Guan.

3.	Fix get_state_synchronize_rcu_full() GP-start detection.

4.	Move RCU Tasks self-tests to core_initcall().

5.	Print segment lengths in show_rcu_nocb_gp_state().

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |    6 ------
 b/init/main.c              |    1 -
 b/kernel/rcu/rcu.h         |    2 +-
 b/kernel/rcu/tasks.h       |    5 ++++-
 b/kernel/rcu/tree.c        |    6 +++---
 b/kernel/rcu/tree_exp.h    |    6 ++++--
 b/kernel/rcu/tree_nocb.h   |   20 +++++++++++++++-----
 kernel/rcu/tree.c          |    9 ++++++---
 8 files changed, 33 insertions(+), 22 deletions(-)
