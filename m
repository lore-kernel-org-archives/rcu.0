Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CDDC433F5
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55BD61220
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 13:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJUNms (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhJUNmr (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Oct 2021 09:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A514D6121E;
        Thu, 21 Oct 2021 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634823631;
        bh=M1UMasLGr3a8/ld2EJZMvFcIs9VoHnE7TLrCdvDaDqw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TCWBnFC1GNuNFG0/GdoZCnXrL2+uyexWNmvdl4h7Or4fL8ETMRVZLNbcOsh42hTCG
         JWjtr/kRBLdqHRctnju9/MOzJ0kxczFGi4VHC9Dt/rVKxyF41omqRQxVLBOr7i6WE1
         9lTWRPIfvZ+N9fRA/ItbwkCiGz1fyEjsPHJG9uRgZRKjIvgvu2eHocsXDqyxggNVUQ
         PuR20SxtkvUhMu+iYjgWxRiWyflqOxrehbjCVfaPW8fTZZgIXFwz+0BY85Dau9c46q
         RgmXr2eFCcMG/epeb+8zDeNKK+ajNKljHh0xZaYZxVZpWGnMrJy0rKRPOrKPqTXOTT
         /r964hh5MWSxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 497015C0966; Thu, 21 Oct 2021 06:40:31 -0700 (PDT)
Date:   Thu, 21 Oct 2021 06:40:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     William Tambe <tambewilliam@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: Re: wait_event_interruptible() causes rcu_note_context_switch() to
 WARN_ON_ONCE() and system hanging
Message-ID: <20211021134031.GR880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAF8i9mMnJGQ1iSUmX5jTF7BNz+TRPA0xPr5VrcaKTADH7DyL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8i9mMnJGQ1iSUmX5jTF7BNz+TRPA0xPr5VrcaKTADH7DyL_Q@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 21, 2021 at 08:22:14AM -0500, William Tambe wrote:
> With PREEMPT_RCU, unless I use following check before calling
> wait_event_interruptible() as follow:
> 
> if (!rcu_preempt_depth())
>         wait_event_interruptible(pu32hdd_wq, (hwdrvblkdev_rqst == 0));
> 
> I am getting the following stack dump and system hanging; any pointers
> as to why could be the reason ?

Because you are not permitted to sleep within an RCU read-side critical
section.  And wait_event_interruptible() does sleep.  So the stack
dump below is the system doing its job and telling you not to invoke
wait_event_interruptible() within an RCU read-side critical section.
And that is the case for CONFIG_PREEMPT=n as well, as you would see if
you built your kernel with CONFIG_PROVE_LOCKING=y.

You would get a similar complaint if you were to invoke this same function
while holding a spinlock, and for similar reasons.

You need to exit the RCU read-side critical section before invoking this
function, or, more likely, one of its callers.

Or it might well be that you are not supposed to sleep at all that deeply
in the block-I/O code path, but that question I must leave to someone
who knows more about the block-I/O subsystem.

							Thanx, Paul

> [    2.217625] ------------[ cut here ]------------
> [    2.218801] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_plugin.h:359 0x828000
> [    2.220019] CPU: 0 PID: 1 Comm: swapper Not tainted
> 5.13.0-00005-g730a9ddaf856-dirty #1
> [    2.221176] stacktrace:
> [    2.225111] 0x00820974 0x000247c2 show_stack+0x64/0x222
> [    2.226481] 0x00820998 0x005c1918 __dump_stack+0x22/0x2c
> [    2.227595] 0x0082099c 0x005c193e dump_stack+0x8/0x12
> [    2.228684] 0x008209a0 0x0002bdb4 __warn+0x10a/0x10e
> [    2.229841] 0x008209c4 0x0002be0a warn_slowpath_fmt+0x52/0x96
> [    2.231045] 0x008209e0 0x00090c7e rcu_note_context_switch+0x112/0x248
> [    2.232337] 0x008209f4 0x005e16d4 __schedule+0x54/0x698
> [    2.233705] 0x00820a28 0x005e1d98 schedule+0x80/0x128
> [    2.234962] 0x00820a34 0x005c0542 hwdrvblkdev_isbsy_+0x78/0x90
> [    2.236355] 0x00820a4c 0x005c02f2 hwdrvblkdev_isrdy+0x2e/0x52
> [    2.237671] 0x00820a50 0x005c0818 pu32hdd_do_request+0x1d0/0x56c
> [    2.238920] 0x00820a98 0x005c0be2 pu32hdd_queue_rq+0x2e/0xdc
> [    2.240087] 0x00820ab8 0x00378c56 __blk_mq_issue_directly+0x64/0x136
> [    2.241311] 0x00820ad8 0x00378e5e __blk_mq_try_issue_directly+0x136/0x16c
> [    2.242561] 0x00820af8 0x0037c002 blk_mq_try_issue_directly+0x36/0xac
> [    2.243821] 0x00820b0c 0x0037cb0c blk_mq_submit_bio+0x4c0/0x4e8
> [    2.245110] 0x00820b50 0x00369da8 __submit_bio_noacct_mq+0x10a/0x156
> [    2.246537] 0x00820b78 0x0036a676 submit_bio_noacct+0x92/0x9c
> [    2.247848] 0x00820b80 0x0036a756 submit_bio+0xd6/0x22e
> [    2.249245] 0x00820be0 0x00196ab8 submit_bh_wbc+0x234/0x428
> [    2.250418] 0x00820c08 0x0019b110 submit_bh+0xe/0x18
> [    2.251540] 0x00820c0c 0x0019e43e block_read_full_page+0x628/0x662
> [    2.252902] 0x00820c78 0x001a0956 blkdev_readpage+0x12/0x1c
> [    2.254101] 0x00820c7c 0x000c35f4 do_read_cache_page+0x178/0x4b4
> [    2.255488] 0x00820ca8 0x000c5e40 read_cache_page+0x10/0x1a
> [    2.256766] 0x00820cac 0x0038c67c read_part_sector+0xd2/0x220
> [    2.257992] 0x00820ccc 0x0038e1ac read_lba+0x1f8/0x238
> [    2.259217] 0x00820d08 0x0038fd4c find_valid_gpt+0x118/0x416
> [    2.260483] 0x00820d44 0x003900a2 efi_partition+0x58/0x54a
> [    2.261853] 0x00820dd0 0x0038b740 check_partition+0x1ac/0x2d4
> [    2.263054] 0x00820dec 0x0038c40a blk_add_partitions+0x84/0x224
> [    2.264277] 0x00820e08 0x001a3798 bdev_disk_changed+0xf6/0x254
> [    2.265581] 0x00820e30 0x001a39b4 __blkdev_get+0xbe/0x3b4
> [    2.266837] 0x00820e50 0x001a3e08 blkdev_get_by_dev+0x8c/0x1bc
> [    2.268121] 0x00820e70 0x00385ef8 disk_scan_partitions+0x14e/0x16c
> [    2.269503] 0x00820e80 0x003877d8 register_disk+0x15c/0x1e2
> [    2.270650] 0x00820e98 0x003879ca __device_add_disk+0x16c/0x2f4
> [    2.271842] 0x00820ec0 0x00387b5e device_add_disk+0xc/0x16
> [    2.273139] 0x00820f60 0x005e0128 kernel_init+0xe/0x128
> [    2.274375] 0x00820f6c 0x005e024a ret_from_exception+0x0/0x8
> [    2.276210] ---[ end trace 9d003344614aff8b ]---
