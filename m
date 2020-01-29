Return-Path: <SRS0=l9jG=3S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D0AC2D0DB
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315C420716
	for <rcu@archiver.kernel.org>; Wed, 29 Jan 2020 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2OXA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:23:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgA2OW7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 09:22:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9F6EEB1A6;
        Wed, 29 Jan 2020 14:22:57 +0000 (UTC)
Date:   Wed, 29 Jan 2020 15:22:55 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     madhuparnabhowmik10@gmail.com
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, frextrite@gmail.com
Subject: Re: [PATCH] cgroup.c: Use built-in RCU list checking
Message-ID: <20200129142255.GE11384@blackbody.suse.cz>
References: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello.

On Sat, Jan 18, 2020 at 08:40:51AM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
> by default.
I assume if you've seen the RCU warning, you haven't seen the warning
from cgroup_assert_mutex_or_rcu_locked() above. 

The patch makes sense to me from the consistency POV.

Acked-by: Michal Koutný <mkoutny@suse.com>

Michal
