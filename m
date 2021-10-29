Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E19C433F5
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098AF610FD
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 16:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJ2Qmp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:42:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35758 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2Qmo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 12:42:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB98E1FD51;
        Fri, 29 Oct 2021 16:40:14 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F5B513DA0;
        Fri, 29 Oct 2021 16:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1/j8NeojfGHoZwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 29 Oct 2021 16:40:10 +0000
Date:   Fri, 29 Oct 2021 09:40:07 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org, philip.li@intel.com,
        lizhijian@cn.fujitsu.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] rcuscale: alwaly log error message
Message-ID: <20211029164007.3ckhrkbvxgyh73ll@offworld>
References: <20211029094029.22501-1-zhijianx.li@intel.com>
 <20211029094029.22501-6-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211029094029.22501-6-zhijianx.li@intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

For the subject you have a typo, I guess you meant 'always'.

Thanks,
Davidlohr
