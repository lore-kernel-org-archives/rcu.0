Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A280283FD0;
	Thu, 18 Sep 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190669; cv=none; b=OjAVtaMc4IjS2FAov8fbgrlyyGWub70lfph6SnSbfxkVswlXkP6oP72O+s6IEj4Gg+U0IrGGGtjiWk/p7B853ZwDJxhJgMKreBeK2KZclatW/O2smbfbWHC1cqIuns6fuk11JPrKSSvPsCHFCoETiZ8ovVuV9iQ7mDIio40XbrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190669; c=relaxed/simple;
	bh=rCx9Xa5CJ0kGwHqMBnQRBfjf8HHDuIdx+9XXCHQZkl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHTmY8rDhS/QSR1zV2Z+KAL+S9bo1SY12Kbfg5LTlJCY4/hPcPh3PZGr76Tjdu2Br+VSB6IeYI727T9nMEH0ZW1Zo8+D51hqiipkiGVGcqjEuMaba30OZCpqLTQgW28rsWZuPA2jJWwSEfPg4twS/HXPyuQKZghn6r2aQQ7HkOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaYi3dHW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaYi3dHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96674C4CEE7;
	Thu, 18 Sep 2025 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190667;
	bh=rCx9Xa5CJ0kGwHqMBnQRBfjf8HHDuIdx+9XXCHQZkl4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WaYi3dHWYOIkj26Tqhic6xFbpdBngMBfp+beduEZFeI3GvJAdEY7HUh6No7YFG8uB
	 +EJVQx5L89JudrLUUsv/aFaQOdwB0whQkN9ym0w9JY29NbaK+/Nk+L9SK33UAAD2tk
	 wF33tgzn7F50smYxhyrDLXakkh+t1LeYL7gd50WRtCcq3yB83aas1ynh1wfM5enLQ/
	 zZOznmts29Z0G8W5qfN6EW4IqaC8XnHo2Wy85MTqLQVhKqjbQJO4+LFnkY11ZYEkH1
	 7WlwLI4gdGuWVOfuWZ9INjmric1mES9C63pOtVcQklPD14REmqgZAKNtsoyFCnXT6d
	 93RnT5tZ9LRNg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0D262CE0B32; Thu, 18 Sep 2025 03:17:47 -0700 (PDT)
Date: Thu, 18 Sep 2025 03:17:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/5] Miscellaneous RCU updates for v6.18
Message-ID: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4c6f496-ca08-46f5-a159-03074a57706a@paulmck-laptop>

Hello!

This v2 series contains miscellaneous RCU updates for v6.18:

1.	Document that rcu_barrier() hurries lazy callbacks.

2.	Remove local_irq_save/restore() in
	rcu_preempt_deferred_qs_handler(), courtesy of Zqiang.

3.	move list_for_each_rcu() to where it belongs, courtesy of Andy
	Shevchenko.

4.	replace use of system_wq with system_percpu_wq, courtesy of
	Marco Crivellari.

5.	WQ_PERCPU added to alloc_workqueue users, courtesy of Marco
	Crivellari.

Changes since v1:

o	Added tags.

o	Added commits 4-5.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/list.h     |   10 ----------
 b/include/linux/rculist.h  |   10 ++++++++++
 b/kernel/cgroup/dmem.c     |    1 +
 b/kernel/rcu/tasks.h       |    4 ++--
 b/kernel/rcu/tree.c        |    5 +++++
 b/kernel/rcu/tree_plugin.h |    5 +----
 kernel/rcu/tree.c          |    4 ++--
 7 files changed, 21 insertions(+), 18 deletions(-)
