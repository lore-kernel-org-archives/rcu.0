Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1EEC433EF
	for <rcu@archiver.kernel.org>; Thu, 17 Mar 2022 15:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCQPvA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbiCQPur (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 17 Mar 2022 11:50:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EF7173360;
        Thu, 17 Mar 2022 08:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12BB1B81EF8;
        Thu, 17 Mar 2022 15:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C16C340E9;
        Thu, 17 Mar 2022 15:49:25 +0000 (UTC)
Date:   Thu, 17 Mar 2022 11:49:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     <paulmck@kernel.org>, <josh@joshtriplett.org>,
        <mathieu.desnoyers@efficios.com>, <jiangshanlai@gmail.com>,
        <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Use printk_deferred when holding rtp->cbs_gbl_lock
Message-ID: <20220317114924.791c6500@gandalf.local.home>
In-Reply-To: <20220317084726.77336-1-zhangqiao22@huawei.com>
References: <20220317084726.77336-1-zhangqiao22@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 17 Mar 2022 16:47:26 +0800
Zhang Qiao <zhangqiao22@huawei.com> wrote:

> This patch tries to avoid this issue by using printk_deferred().

Isn't the new printk work suppose to resolve this?

If so, can we have another way to quiet these splats if that work is not in
yet?

-- Steve
