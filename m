Return-Path: <SRS0=6iKH=BX=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A5C433DF
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 22:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D320771
	for <rcu@archiver.kernel.org>; Thu, 13 Aug 2020 22:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMWxv convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Thu, 13 Aug 2020 18:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgHMWxu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 13 Aug 2020 18:53:50 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8518AC061757;
        Thu, 13 Aug 2020 15:53:50 -0700 (PDT)
Received: from localhost (50-47-103-195.evrt.wa.frontiernet.net [50.47.103.195])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C49BA128286E7;
        Thu, 13 Aug 2020 15:37:03 -0700 (PDT)
Date:   Thu, 13 Aug 2020 15:53:48 -0700 (PDT)
Message-Id: <20200813.155348.1997626107228415421.davem@davemloft.net>
To:     xiangxia.m.yue@gmail.com
Cc:     joel@joelfernandes.org, jknoos@google.com, gvrose8192@gmail.com,
        urezki@gmail.com, paulmck@kernel.org, dev@openvswitch.org,
        netdev@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH v2] net: openvswitch: introduce common code for
 flushing flows
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200812095639.4062-1-xiangxia.m.yue@gmail.com>
References: <20200812095639.4062-1-xiangxia.m.yue@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 13 Aug 2020 15:37:04 -0700 (PDT)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: xiangxia.m.yue@gmail.com
Date: Wed, 12 Aug 2020 17:56:39 +0800

> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> To avoid some issues, for example RCU usage warning and double free,
> we should flush the flows under ovs_lock. This patch refactors
> table_instance_destroy and introduces table_instance_flow_flush
> which can be invoked by __dp_destroy or ovs_flow_tbl_flush.
> 
> Fixes: 50b0e61b32ee ("net: openvswitch: fix possible memleak on destroy flow-table")
> Reported-by: Johan Knöös <jknoos@google.com>
> Reported-at: https://mail.openvswitch.org/pipermail/ovs-discuss/2020-August/050489.html
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Applied, thank you.
