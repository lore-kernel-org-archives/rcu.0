Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6A4C433EF
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE08660F50
	for <rcu@archiver.kernel.org>; Thu, 21 Oct 2021 13:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUNYm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJUNYm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Oct 2021 09:24:42 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742FDC0613B9
        for <rcu@vger.kernel.org>; Thu, 21 Oct 2021 06:22:26 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id l201so129565ybl.9
        for <rcu@vger.kernel.org>; Thu, 21 Oct 2021 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=wFzsWEMJIvyQr6B90mKIpMaVlKJz6itGDkQSed3Jkts=;
        b=WbjGLj7j6AvRy/ZIRqDNzyHQ13YABwJgBpHuTHClNFvD8OG635AnLfDVQq7nZvWeoQ
         Htd7PFjTzX3XBvtnfhSwkF7tIAtPUSLsgYOh31eVk+/t7B9ssZ3V5sHgPmALHApieTr2
         ZgSsV03y8xB17gw2OhQ2s0J7ocqHFYhrmY06F6zNbhZ2wUbu9XTFeEAYkCaxmUCMl/ph
         aZmYzY1R2SqHd+ftTozKQog8+JlkeXJfZWnp5xpNg3TvbkNJUmapHmZ/82ifNJVMQKNm
         Jx3S1NHP0uD290DKq0CiuknTYqonBtngEWl4jYquiD+cbX0hY5jEGL2dS5YA6I8J+MIQ
         wJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wFzsWEMJIvyQr6B90mKIpMaVlKJz6itGDkQSed3Jkts=;
        b=xNn+5rzvKnhjynFWWNtSo5HxD6feqSjHPWe+pkNT8d6Z/2zqf7cAvVifbQcBU98KoZ
         lcjH2ib6qASkhas4uoEyaoEtK1rfftwjvC/ElkVhDhNkheWdrQ6QfgWQeXV+5aleErmG
         IUzliiqSUzvrr5mMF0iLO0bfhMyrZadtkzS8YrvtkIRKrnNloG0kiGCAYTwn2rFxUJZw
         QgaofG7tRih9SECYpJqX+SNn/re9ubgo5qIub/o9zLnzAIJv6za6BWAAOnYTA19dOqC9
         CUtduvVUtFsyh3AixMDutBMOh+lkN8ghXJEHfI8MUqKT5218PN6eNb7725b14DEvesJ6
         +Zzw==
X-Gm-Message-State: AOAM5306bNU3yPI3Ogmyyb/8NpNdNEMjE9Moda3GNq3fFKVVCaF91rWK
        3UHrj55yXx0pZy5I+wHIHyf6bLmezOXgLQOsOih2aT157Dg=
X-Google-Smtp-Source: ABdhPJw4M1yNzAXpdoQWpfQOzEnFb1OTUoW/W10F2ZwhScOD484HUlBEfs9vpvDo24wIeoJ8csdmCV2urs42pybP9AM=
X-Received: by 2002:a25:a4e1:: with SMTP id g88mr3605387ybi.58.1634822544863;
 Thu, 21 Oct 2021 06:22:24 -0700 (PDT)
MIME-Version: 1.0
From:   William Tambe <tambewilliam@gmail.com>
Date:   Thu, 21 Oct 2021 08:22:14 -0500
Message-ID: <CAF8i9mMnJGQ1iSUmX5jTF7BNz+TRPA0xPr5VrcaKTADH7DyL_Q@mail.gmail.com>
Subject: wait_event_interruptible() causes rcu_note_context_switch() to
 WARN_ON_ONCE() and system hanging
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

With PREEMPT_RCU, unless I use following check before calling
wait_event_interruptible() as follow:

if (!rcu_preempt_depth())
        wait_event_interruptible(pu32hdd_wq, (hwdrvblkdev_rqst == 0));

I am getting the following stack dump and system hanging; any pointers
as to why could be the reason ?

[    2.217625] ------------[ cut here ]------------
[    2.218801] WARNING: CPU: 0 PID: 1 at kernel/rcu/tree_plugin.h:359 0x828000
[    2.220019] CPU: 0 PID: 1 Comm: swapper Not tainted
5.13.0-00005-g730a9ddaf856-dirty #1
[    2.221176] stacktrace:
[    2.225111] 0x00820974 0x000247c2 show_stack+0x64/0x222
[    2.226481] 0x00820998 0x005c1918 __dump_stack+0x22/0x2c
[    2.227595] 0x0082099c 0x005c193e dump_stack+0x8/0x12
[    2.228684] 0x008209a0 0x0002bdb4 __warn+0x10a/0x10e
[    2.229841] 0x008209c4 0x0002be0a warn_slowpath_fmt+0x52/0x96
[    2.231045] 0x008209e0 0x00090c7e rcu_note_context_switch+0x112/0x248
[    2.232337] 0x008209f4 0x005e16d4 __schedule+0x54/0x698
[    2.233705] 0x00820a28 0x005e1d98 schedule+0x80/0x128
[    2.234962] 0x00820a34 0x005c0542 hwdrvblkdev_isbsy_+0x78/0x90
[    2.236355] 0x00820a4c 0x005c02f2 hwdrvblkdev_isrdy+0x2e/0x52
[    2.237671] 0x00820a50 0x005c0818 pu32hdd_do_request+0x1d0/0x56c
[    2.238920] 0x00820a98 0x005c0be2 pu32hdd_queue_rq+0x2e/0xdc
[    2.240087] 0x00820ab8 0x00378c56 __blk_mq_issue_directly+0x64/0x136
[    2.241311] 0x00820ad8 0x00378e5e __blk_mq_try_issue_directly+0x136/0x16c
[    2.242561] 0x00820af8 0x0037c002 blk_mq_try_issue_directly+0x36/0xac
[    2.243821] 0x00820b0c 0x0037cb0c blk_mq_submit_bio+0x4c0/0x4e8
[    2.245110] 0x00820b50 0x00369da8 __submit_bio_noacct_mq+0x10a/0x156
[    2.246537] 0x00820b78 0x0036a676 submit_bio_noacct+0x92/0x9c
[    2.247848] 0x00820b80 0x0036a756 submit_bio+0xd6/0x22e
[    2.249245] 0x00820be0 0x00196ab8 submit_bh_wbc+0x234/0x428
[    2.250418] 0x00820c08 0x0019b110 submit_bh+0xe/0x18
[    2.251540] 0x00820c0c 0x0019e43e block_read_full_page+0x628/0x662
[    2.252902] 0x00820c78 0x001a0956 blkdev_readpage+0x12/0x1c
[    2.254101] 0x00820c7c 0x000c35f4 do_read_cache_page+0x178/0x4b4
[    2.255488] 0x00820ca8 0x000c5e40 read_cache_page+0x10/0x1a
[    2.256766] 0x00820cac 0x0038c67c read_part_sector+0xd2/0x220
[    2.257992] 0x00820ccc 0x0038e1ac read_lba+0x1f8/0x238
[    2.259217] 0x00820d08 0x0038fd4c find_valid_gpt+0x118/0x416
[    2.260483] 0x00820d44 0x003900a2 efi_partition+0x58/0x54a
[    2.261853] 0x00820dd0 0x0038b740 check_partition+0x1ac/0x2d4
[    2.263054] 0x00820dec 0x0038c40a blk_add_partitions+0x84/0x224
[    2.264277] 0x00820e08 0x001a3798 bdev_disk_changed+0xf6/0x254
[    2.265581] 0x00820e30 0x001a39b4 __blkdev_get+0xbe/0x3b4
[    2.266837] 0x00820e50 0x001a3e08 blkdev_get_by_dev+0x8c/0x1bc
[    2.268121] 0x00820e70 0x00385ef8 disk_scan_partitions+0x14e/0x16c
[    2.269503] 0x00820e80 0x003877d8 register_disk+0x15c/0x1e2
[    2.270650] 0x00820e98 0x003879ca __device_add_disk+0x16c/0x2f4
[    2.271842] 0x00820ec0 0x00387b5e device_add_disk+0xc/0x16
[    2.273139] 0x00820f60 0x005e0128 kernel_init+0xe/0x128
[    2.274375] 0x00820f6c 0x005e024a ret_from_exception+0x0/0x8
[    2.276210] ---[ end trace 9d003344614aff8b ]---
