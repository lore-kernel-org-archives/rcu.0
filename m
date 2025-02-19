Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736411F426F;
	Wed, 19 Feb 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973486; cv=none; b=hdTQcraCOqfsvCOrBhtcZkvsNPOTtQ+/pXoWpEUjV+2qBt9YVwcvO2JJu5G9r44cC9lBk7VreAx+yJ99Hv265kQFe69REDMbqqZ744guygAxK96x10LyuZR8lOoS7Vc4QaMW2YteqoCmRVxWGHqJoHyBemPwfws6/Vc/hAVhtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973486; c=relaxed/simple;
	bh=WalWz80t0PynaBELBTIscR8pkNUsFIOizWMAEnD7w6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOaHFdxJH7RWEHFaO1r+cdbTHu8nVIH7sEB9NakP6QDoDKTMWecw1Sx7GhAho+uqEMJjAtluvJ2ORyQt8R8vAQqHv39JLyyMKiJLJ/ntArX6hksxvqqBie5lkwZzE8HxX727aWgf61TP9NxnUJWQSX8dAjLPfHdPEY1ebJt+pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD6xFqWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD6xFqWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E681DC4CED1;
	Wed, 19 Feb 2025 13:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973485;
	bh=WalWz80t0PynaBELBTIscR8pkNUsFIOizWMAEnD7w6c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=aD6xFqWPxRvjY1HUlH71YzSkYaU5DYGTnkCCu0Jo+lu0rH0glwR26h6Nsmqy3N9T3
	 px7MDGJcHf9s09ECwBmt8bIkzY0yeibH7W9v1UBXnsFWpqKbxSg9vTcKGfpCZwU7w4
	 KR0oLbBqqcrgL3zvmUEd8Kd4f+rZ1lSDZQ67D0/7ooIRMtvvmyLiqKxbJ7ITUiIe+b
	 eWt5BDHv/OM8uxJPO+tQ1gemaSoK7ZWvTKcPr8fjXL3HxrpNkXM7amwvvtNe+s1A6Y
	 RJrsdHaxwedBUvvbUpP8Ea6Hynm6rLe+QQmNp1HyXtW9REtToXWOxcvjw5ouHCJ5kM
	 MRib+A/Zizg5Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 897F9CE0BDE; Wed, 19 Feb 2025 05:58:05 -0800 (PST)
Date: Wed, 19 Feb 2025 05:58:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: syzbot <syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com>,
	jiangshanlai@gmail.com, josh@joshtriplett.org,
	linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rcu?] WARNING in srcu_invoke_callbacks (2)
Message-ID: <27f4ffbe-2342-484d-9924-716a799b265f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <67b4c7af.050a0220.14d86d.000a.GAE@google.com>
 <20250219132538.GA468969@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219132538.GA468969@joelnvbox>

On Wed, Feb 19, 2025 at 08:25:38AM -0500, Joel Fernandes wrote:
> On Tue, Feb 18, 2025 at 09:47:27AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    a64dcfb451e2 Linux 6.14-rc2
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12398f18580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c47badcd079906
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ae5b16688c0c675b1a1f
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c0a862fcec77/disk-a64dcfb4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/f03793fc001b/vmlinux-a64dcfb4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/ae71c33eae14/Image-a64dcfb4.gz.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ae5b16688c0c675b1a1f@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 6430 at kernel/rcu/srcutree.c:1798 srcu_invoke_callbacks+0x368/0x3d8
> 
> This is weird, happens to be WARN_ON_ONCE(ready_cbs.len); in
> srcu_invoke_callbacks().

Thank you for tracking that down!

> Perhaps, stack corruption or the SRCU cblist's ->seglen got corrupted?

That has been the usual cause.  And a double call_srcu() is a common
cause of ->cblist corruption.  We have CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
set up for SRCU as well as for RCU, it appears, so perhaps retry with
that should this ever become reproducible?

							Thanx, Paul
