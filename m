Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9A23AE87;
	Wed,  5 Nov 2025 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383974; cv=none; b=u5l6wpR+bQcdImkPtTd6LtNo6kKOKp0Rmzs+q2mWFa89cCt1BV6A+fsFqxAoL4oqNGg0pOxP1a65NdYeO5mdilcNwKPYzJVYDml342rBTi7Gz7dkiLhFhj+N3JXJUaEg4YLndGWHmzNgRjTKaymRYvhLCUKFbQvqMY+iQ8ACVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383974; c=relaxed/simple;
	bh=NwFAwwYZsRXZrOx7c9jrUCV4LK5QWsKBDI321X8Dgq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qE3Z8q1i41AAIyxJoBkjKaQK7F1E4qgRyY+xjAxSCQ56p81kPQ4eP1j/ki7HIZT3pCk9MCegEzhmGO1sGS6ZU16brOkGaGrxRyhpRktQF4EtiubqVIT81VVYXpAcAlc3q9MVEid/yoxumcNJWHtghC+EMBLWS+PTcxyJ5ArcRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFZZF7hi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFZZF7hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859F1C4CEF5;
	Wed,  5 Nov 2025 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762383973;
	bh=NwFAwwYZsRXZrOx7c9jrUCV4LK5QWsKBDI321X8Dgq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFZZF7hi9c2wsAgGbgl+qVsFO5RTt5BTd9xY89ZatYhtLvtYDsjIP4OZ4qQCfXVd0
	 raTIocQveG1V+h2Juyv2b8gf4zlJVkhdBZuAnVPab+QAEqFGjDWI5j4MgAf5wOlOr5
	 nRKN8XjyNTcF3tudalgv97cRbdY9xHJFqxIW/lYD3L/VhynHSTgPgLL5+jhyZMzk2V
	 XNV6qX4SUWbT7LeHjNdIJXX5yNfts4GSRVEakCQCyaWcuPgGzAbl3x3ZdYVuZHla3W
	 x/xKhaeD/2wmCv6mHEtYi1iWH0HCsRDnucKF4qE4kgw5HdfNT9rKleVk9v1DUKP4zk
	 04XBHflh0enSQ==
Date: Thu, 6 Nov 2025 00:06:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 0/5] Miscellaneous RCU updates for v6.19
Message-ID: <aQvYYq3ym9mbHZb5@pavilion.home>
References: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf8b57e0-1803-45e9-a217-9c9aeb64a2f9@paulmck-laptop>

Le Wed, Nov 05, 2025 at 12:19:51PM -0800, Paul E. McKenney a écrit :
> Hello!
> 
> This series provides miscellaneous RCU updates:
> 
> 1.	Fix memory leak in param_set_cpumask(), courtesy of Wang Liang.
> 
> 2.	use WRITE_ONCE() for ->next and ->pprev of hlist_nulls, courtesy
> 	of Xuanqiang Luo.
> 
> 3.	Add kvm-series.sh to test commit/scenario combination.
> 
> 4.	Permit kvm-again.sh to re-use the build directory.
> 
> 5.	Remove redundant rcutorture_one_extend() from
> 	rcu_torture_one_read().
> 
> Changes since v1:
> 
> o	Make kvm-again.sh able to reuse the rcutorture res directory
> 	in support of upcoming parallel execution of kvm-series.sh
> 	guest OSes.  This is #3 above.
> 
> o	Remove a redundant call to rcutorture_one_extend().  This is
> 	#4 above.
> 
> o	Add the SPDX line to kvm-again.sh and remove a trailing space
> 	character from the comment header.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  include/linux/rculist_nulls.h                        |    6 
>  kernel/locking/locktorture.c                         |    8 -
>  kernel/rcu/rcutorture.c                              |    4 
>  tools/testing/selftests/rcutorture/bin/kvm-again.sh  |   56 ++++++---
>  tools/testing/selftests/rcutorture/bin/kvm-series.sh |  116 +++++++++++++++++++
>  5 files changed, 166 insertions(+), 24 deletions(-)
>

Applied to rcu/misc (and also applied the refscale patches for rcu/refscale).

Thanks!

-- 
Frederic Weisbecker
SUSE Labs
