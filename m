Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6C3101C0;
	Fri,  8 May 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262219; cv=none; b=Og2VxHEoaJhPW/b4cMNjlyInFRYRtjg/1KX8XgL+8RwJ9ygP5/tVnIVACW77L/K3M6yD1cLU9yf6n9H//wY2+8Qwlz1On2/sD8RRQ2jyOdESUfbyP4uTQx61Ids7UbQXLkucX5qT7702ppR1+eBvNM1oQ8gi2b8DS8BXnXNcfNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262219; c=relaxed/simple;
	bh=mjT1vDNXGpoFKrGURCgweLXh/3tNKKfI0b/OGaiRwPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVLY921CauND8f+7wZpg7v9QiDzI9EIf6d+r1FxM3g+Zlw0aPng7IPAgTu4GijjVLuX4I/t9rpZzvhMqeZfxHFZ/Un4XRM135UP9AxBpfOPdZ8UwpYwHY1WsslGyjegOFZgALq0IJKWKWEtlGHPwZhJPA2wur4VjfYebT7BVQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+PBXZTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+PBXZTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AE1C2BCB0;
	Fri,  8 May 2026 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262219;
	bh=mjT1vDNXGpoFKrGURCgweLXh/3tNKKfI0b/OGaiRwPE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=T+PBXZTS8VNlzn6Cshnz6CPzKf9jgH9MNHH8pZfTCcFAoAz5K5nN3tMN9rG45QcfR
	 kG2DBbOev1+kAJTMwj4o48/zmDqTqJffYKMN5CaL7f6S36dWQWjPsFhwiFBX9f26Ft
	 SReINrqWCPDk8PEmcci5qMNJOjiTODaSbZoPl5615MUG2jS8DGfUwkVXqU7llLK0Ja
	 rtE6KRbwudvtMKSPW10WNcTBLU7ReWk4MjAU8tDkSNA0ZUNkjRkn2zORFsd1AV4AiX
	 Nwp33zvWQzBPwRXI6w3siK+KCpkoMFuz6E0oqYzjPfqkHHG0MwpWkjcHVOP3pfWEsn
	 SuvoIO2JYfnPg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD361CE06FB; Fri,  8 May 2026 10:43:38 -0700 (PDT)
Date: Fri, 8 May 2026 10:43:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/6] Miscellaneous RCU changes for v7.2
Message-ID: <40ed4910-e20b-40a6-9598-7aa6abf006c5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>

Hello!

This series contains v2 of the miscellaneous RCU updates for v7.2:

1.	Don't queue workqueue handlers to never-online CPUs.

2.	Fix kerneldoc header comment typo in srcu_down_read_fast().

3.	Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace().

4.	Simplify rcu_do_batch() by applying clamp().

5.	Simplify param_set_next_fqs_jiffies() by applying clamp_val().

6.	Document rcu_access_pointer() feeding into cmpxchg().

Changes since v1:

o	Merge the two checkpatch commits (#3 and #4 in v1) into a single
	commit (#3).

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h |   12 +++++++-----
 b/include/linux/srcu.h     |    2 +-
 b/kernel/rcu/srcutree.c    |   12 ++++++------
 b/kernel/rcu/tree.c        |    2 +-
 b/scripts/checkpatch.pl    |    5 +++--
 kernel/rcu/tree.c          |    2 +-
 6 files changed, 19 insertions(+), 16 deletions(-)
