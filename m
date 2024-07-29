Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F15130A7D
	for <rcu@vger.kernel.org>; Mon, 29 Jul 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241545; cv=none; b=KszmWdXyglPUeGIJSgFIt4wMBnI99Xu7CqUqVLNtA2zwlrqYHq+8N2dodjOOu+hSjqIG6zNJzo+JWSV1HYhZ75aIAPYfpcEWF4xyKSYkdWJuaA0GI/5uW/GT+xMBTkU4NIvI0aME0imbtWnuqkC3Y2KvHQOtYz8lPiwn6G2IYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241545; c=relaxed/simple;
	bh=PURHL43L2kM4p2Y8RudvzBafp3DO3GObN0EgL/pJfkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzVSBaecP2jjS/3zXEohEaSHKnp9qEy8YSy4ytzD33dtXnHRNmMydslPWHjFqiHshiobYSkbrVw3CvwXCILaKaKxg0UGEzHe3PhNQYFd+QwBh3eo2abXkfJYVA/3V0Jn++ARHwwXp/hy1seaxmIZcLHbbJTfs9P7n3axjnUCVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgEh4Va1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgEh4Va1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD749C32786;
	Mon, 29 Jul 2024 08:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722241544;
	bh=PURHL43L2kM4p2Y8RudvzBafp3DO3GObN0EgL/pJfkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qgEh4Va1aWYI0KeqZubByiItSHPUbDJQWE9RJPkcpKPcp9UORuSq63nnnpHwADeIN
	 0QfTKKpwEnRaH7AG9SCvASKTyg/juVufeK0DDJvtxHAumlJRMcmxqY4ElX9fA0Tth9
	 d/i4wq04w4CCTI5M+xoX6d1hGXD6shb6n4dxje9zixRiKW5EwsiC5NX8bNnnDAueOG
	 5hH2OFZ+g6P4XrcikGEed/7WBwuvkxC8lb3M03mKDH1/xrhL6Y4N2gbSjvnXgzrfu3
	 vht7J0/ODZmUVrrb6KxtvYizisvfONVrCjYGK6VI7PS0y/MJ+TtVkBTSIPslwjEeuw
	 9Qu4CAmAgGXxg==
Date: Mon, 29 Jul 2024 10:25:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Hillf Danton <hdanton@sina.com>, 
	paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: rcu_sync_dtor() warning question
Message-ID: <20240729-imponieren-webstuhl-8ed39923df25@brauner>
References: <20240726-ansonsten-piste-c4f04d4909fc@brauner>
 <f4d23fa4-b324-4666-aeb3-ace5c0384e07@paulmck-laptop>
 <CAGudoHHn4bmdR0LetX_bJ1PMtuc6cEYd=hZFutXmqaMG1H+rCg@mail.gmail.com>
 <CAGudoHGznS_Br2gxu=BWsDaCbHmMWRTCmoZDniyFFrDOs9VD5A@mail.gmail.com>
 <20240728134101.GA8691@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240728134101.GA8691@redhat.com>

On Sun, Jul 28, 2024 at 03:41:01PM GMT, Oleg Nesterov wrote:
> Sorry for late reply.
> 
> You do not need my help, I know nothing about fs ;)  but just in case...
> 
> On 07/26, Mateusz Guzik wrote:
> >
> > Welp.
> >
> > syzbot did the bisect, it's not any of the above, instead:
> >
> > commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
> > Author: Chao Yu <chao@kernel.org>
> > Date:   Sun Apr 23 15:49:15 2023 +0000
> >
> >     f2fs: support errors=remount-ro|continue|panic mountoption
> >
> > https://lore.kernel.org/linux-fsdevel/0000000000004ff2dc061e281637@google.com/T/#m90c03813e12e5cdff1eeada8f9ab581d5f039c76
> >
> > That said, the stuff I mentioned still looks highly suspicious so I
> > have to something to investigate regardless.
> 
> Did you see the patch from Hillf ?
> https://lore.kernel.org/all/20240727011616.2144-1-hdanton@sina.com/
> it seems to fix the problem...

I only skimmed the bisect while I was entertaining a toddler during a
trainride. :)

> 
> Of course I don't understand this patch, but afaics SB_RDONLY can confuse
> thaw_super_locked(). If sb_rdonly() is true, thaw_super_locked() assumes
> that freeze_super() didn't call sb_wait_write() -> percpu_down_write().
> 
> So in this case thaw_super_locked() just clears sb->s_writers.frozen and
> goes to the "out_deactivate" label bypassing sb_freeze_unlock().

So the thing is that remounting a superblock read-only directly without
going through the VFS first is pretty risky and is likely to cause
trouble. The order of operations to transition rw->ro:

(1) Check that the filsystem is unfrozen. If not, fail with EBUSY.
(2) Mark all mounts of that filesystem as read-only. Fail with EBUSY if
    there are any active writers on any of the mounts.
(3) Call into ->reconfigure() method of the filesystem so it can do it's
    internal thing to mount read-only.

All of that requires sb->s_umount semaphore to be held. But f2fs
seems to transition rw->ro without holding sb->s_umount in various
callsites of:

f2fs_stop_checkpoint()
-> f2fs_handle_critical_error()

So that would mean freeze_super() would've indeed acquired
percpu_down_write(SB_FREEZE_WRITE+SB_FREEZE_PAGEFAULT+SB_FREEZE_FS) but
thaw_super() would skip calling
sb_freeze_unlock(SB_FREEZE_FS+SB_FREEZE_PAGEFAULT+SB_FREEZE_WRITE) and
destroying the superblock during umount with an imbalance that gets
noticed in rcu_sync_dtor().

So afaict this would mean that we never called rcu_sync_exit() and thus
never set GP_EXIT and notice that imbalance during rcu_sync_dtor().
