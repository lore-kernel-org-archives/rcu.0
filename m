Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698328002B;
	Thu, 31 Jul 2025 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005133; cv=none; b=T21p5SHCuEuD/mvT8eQGxZENH2qkNp5i8C6jKVOu4CbaZTlyhXKLoOdw6oBHMTiPWyLYDQD4bYinLpqfk9vMwILEW39RmF0GQTV0tVdNrX7oqQULKwb7FREqhFECl+X34UBaUVBfW0yDpQyck6azSIWp/2/6d4u9mwVltP55IQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005133; c=relaxed/simple;
	bh=ORv11BBiZIIxB64dqC73Reod0GBkNGunSRKP0P9RJkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpccA6Wj08TuYSc4O2779gBqZJoAoQu99xBPx1IXdTSyGSc7obNehfow8qODH8rUOGw4BaRLECOTEELku76JMjbVAJqbdE7nDSIUeOs8HwI5vvbUglfUzYmjJ5Eav7PSe40Dkt25JtT0SVNd0QaSfiHzTRKt+R8ujaDkJij3eTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOH+cjZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOH+cjZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2E9C4CEEF;
	Thu, 31 Jul 2025 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754005133;
	bh=ORv11BBiZIIxB64dqC73Reod0GBkNGunSRKP0P9RJkE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gOH+cjZz85UXcqUOBspAaljr2Q8fhdksocWrc3mSqcar3rvVhx5CEmtzT00J+j8Wa
	 hoi+qUkBIaejm2lRq0BeRo0QjnYNrZiUimiWaypivJl5ZPcafeCF1v/X6pBqWu15Jr
	 aaEFXN9hOETgbwpdFTDWoH4LbuCNV9lao+iMBwIdEI0A9eiWl86Pfq/EnXoP9Px/Ab
	 kCFwRYm8O/En7zMLwS/3XKOPiihed4NZih0YyH5Ig2UYR/XNn12Ut8xjkvpOIbNYBD
	 Cn0SOZSykGWyHCU/+fDzSoen4s93faGh1puj5Yq3LWFvgF2yt0jmX9J/1g6AUUvK55
	 kzdl/HYFvBiQQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD740CE09FA; Thu, 31 Jul 2025 16:38:52 -0700 (PDT)
Date: Thu, 31 Jul 2025 16:38:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Yuzhuo Jing <yuzhuo@google.com>
Cc: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yzj@umich.edu>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Frank van der Linden <fvdl@google.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v1 0/4] rcuscale: Add debugfs file based controls and CPU
 affinity offset
Message-ID: <185c8c12-4d6d-41a2-bb04-dfe1d00d01c4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>

On Tue, Jul 29, 2025 at 07:23:43PM -0700, Yuzhuo Jing wrote:
> In an effort to add RCU benchmarks to the perf tool and to improve
> the base-metal rcuscale tests, this patch series adds several auxiliary
> features useful for testing tools.
> 
> This series introduces a few rcuscale options:
>   * writer_no_print: skip writer duration printing during shutdown, but
>     instead let users read from the new "writer_durations" debugfs file.
>     This drastically improves cleanup speed.

But existing scripts running something like this will continue to
work, correct?  (It looks like they do, just checking.)

tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 5

Don't get me wrong, your debugfs read-out performance increase looks
quite good, but these tests run in a guest OS with minimal userspace.
And by "minimal", I mean that they run out of an initrd having a root
filesystem consisting of a single statically linked "init" program.  ;-)

>   * block_start: an option to hold all worker thread until the new
>     debugfs "should_start" file is written.
>   * {reader,writer,kfree}_cpu_offset: the starting value of CPU affinity
>     for each type of threads.  This can be used to avoid scheduling
>     different types of threads on the same CPU.  The 4th patch in this
>     series shows drastic performance differences w/ and w/o overlaps.

The usual use cases run only writers except for stress tests, but this
seems like a good capability.

> This patch series creates an "rcuscale" folder in debugfs, containing
> the following files:
>   * writer_durations: a CSV formatted file containing writer id and
>     writer durations.
>   * {reader,writer,kfree}_tasks: the list of kernel task PIDs for
>     external tools to attach to.
>   * should_start: a writable file to signal the start of the experiment,
>     used in conjunction with the new "block_start" option.
>   * test_complete: a readable file to indicate whether the experiment has
>     finished or not.
> 
> RFCs:
>   * Should those new files reside in debugfs or in procfs?

New files in procfs face serious scrutiny, so your choice of debugfs
is a good one.

>   * What format should be used for the writer_duartions file, and what
>     documentations should be updated for the file format definition?

Back in the old days, I would have insisted on space/tab separated fields.
But gawk now supports a --csv flag, so I don't feel strongly about this.

>   * In the 4th patch, we see different characteristics between overlap
>     and non-overlap.  Current rcuscale creates nr_cpu readers and nr_cpu
>     writers, thus scheduling 2nr_cpu tasks on nr_cpu CPUs.  Should we
>     consider changes to this behavior?  Or add automatic conflict
>     resolutions when total threads <= nr_cpu.

The theory back in the day was that the updater would spend enough time
blocked that this would not matter.  However, you have shown that it
clearly does matter.

Except that running the reader and writer on the same CPU seems to
*improve* grace-period latency, with P99 value duration of 121,004
microseconds for overlapping (your first patch 4/4 experiment) and of
218,018 microseconds for non-overlapping.  Since shorter grace periods
are usually considered better, this suggests better performance with
the reader and writer running on the same thread.

Or am I misreading your commit log?

It would not be too surprising for the overlapping case to provide
faster grace periods because you are running PREEMPT=n and the writer
kthread would force context switches more frequently.  But I figured
that I should check.

> Thank you!
> 
> Yuzhuo Jing (4):
>   rcuscale: Create debugfs file for writer durations
>   rcuscale: Create debugfs files for worker thread PIDs
>   rcuscale: Add file based start/finish control

This does not apply on the dev branch of my -rcu tree.  Which is not too
surprising because kernel-parameters.txt is subject to change.  But when
you repost to fix the bug that kernel test robot detected, could you
please let me know what mainline version you are developing against?
That would allow me to apply it there and then to rebase and resolve
conflicts as needed.

							Thanx, Paul

>   rcuscale: Add CPU affinity offset options
> 
>  .../admin-guide/kernel-parameters.txt         |  29 ++
>  kernel/rcu/rcuscale.c                         | 361 +++++++++++++++++-
>  2 files changed, 377 insertions(+), 13 deletions(-)
> 
> -- 
> 2.50.1.552.g942d659e1b-goog
> 
