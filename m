Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AC8F6C;
	Mon, 21 Jul 2025 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109641; cv=none; b=EsSqJw0OXE2gytkme29jzhm0KJvXyYS4kgrxNu+UGCSUK9kGk+HD7W4mfPRKguDsbKKOIROT8t+qhX1pZyHEOcIkdTCiM40NFFKtOyFhtuN2r/BiM6jEkHOa3RVOP6PjRNjdHYB5vLAvEUu8NRNE/1Es5wTsz0h5TTf0CF20K+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109641; c=relaxed/simple;
	bh=uGPXYh19g0pPDrhe/mLF3iCb+LkIqLsf4TZSWhmSpbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oB5JWxbFsWklIu4BJ2CyxNAMvB48omedLCCjM3rQEHbHbklprUMHtMxzKHhVMbWnIocHtMGlVL1P6vomXpcUrpvs9oSfQc+IDL/auiH11mxz+ToKBoShDQsuphCNCR6EYVy1iuBe2cpkgwtMlDf0B/HoNwwpZ0dMgW+D0uRSVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 63F965AE9D;
	Mon, 21 Jul 2025 14:53:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 80A792002E;
	Mon, 21 Jul 2025 14:53:49 +0000 (UTC)
Date: Mon, 21 Jul 2025 10:53:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/4] srcu: Move rcu_is_watching() checks to
 srcu_read_{,un}lock_fast()
Message-ID: <20250721105348.05312994@batman.local.home>
In-Reply-To: <20250719002817.4121867-1-paulmck@kernel.org>
References: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
	<20250719002817.4121867-1-paulmck@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 94xef5no8umymuibh4po4rx341aiwdau
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 80A792002E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nDBllZm2cMNRAPa6Lpi/jy1X06l/eUlQ=
X-HE-Tag: 1753109629-336549
X-HE-Meta: U2FsdGVkX19kj9BvEdOe4+f3V3KIk69ZmWp0D48s8zXODiyf+c7BUMxrhun/67QhQ2XBUbTQ0QQ9gi0viFn99OW1peRU+3bY0U7w/V+SR5oWalaE7BYIDUQ6EwFbRVFFbrWt6kYZdi6GEZpUgB9kF672KjwD7btcx4RN9xhoRXWEIVm1LXA5xhYhT8abURyP8/yHn4GWHQ6kBkk2qYxjD9yq2B75R9EkfgPcGPtHp232tjQ7+27sJubJEecEXR7F2N2cRYRn8aINAI7ILKF6cARgN1yVnSE16vHmH5JRjWhBYddB9r4G/fAJ7+OlKjN6HZl5fqVBXluzhRbA/EnIEL1g67iBAZwA

On Fri, 18 Jul 2025 17:28:14 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> The rcu_is_watching() warnings are currently in the SRCU-tree
> implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
> However, this makes it difficult to create _notrace variants of
> srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
> moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
> srcu_down_read_fast(), and srcu_up_read_fast().
> 

Paul,

Can you please send new versions of a patch set as a separate thread?
It is really difficult to sort out what patch goes with what when they
are all in the same thread. Even in tree view.

-- Steve
