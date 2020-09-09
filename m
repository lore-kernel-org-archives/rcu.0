Return-Path: <SRS0=NFG3=CS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8271C43461
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917142177B
	for <rcu@archiver.kernel.org>; Wed,  9 Sep 2020 00:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599611274;
	bh=2LZCwU8UpJcj0ae9NmaJz2EpwentD/rjiwDLn66U+d4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OPPr38TipGh6neI4uSkgaO9JzZoHiUd/Orsf4g+rAFSiS+oP89bDxNDY63i1v4gyL
	 wq2S7gs72HB3H5LzzYacXUXisCo3Zo/tOmEu8wZrBAHgD3NiMgtaZx3ZMqNGCeLvhl
	 l72a0UaMaLCqQnimxn6debVXYSAGylMxFhkw1Jyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIIA1y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgIIA1x (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 8 Sep 2020 20:27:53 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF832145D;
        Wed,  9 Sep 2020 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599611273;
        bh=2LZCwU8UpJcj0ae9NmaJz2EpwentD/rjiwDLn66U+d4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fzFmi5nKxcXnvPQpdMiRMsZ5EEaKi1c4xG2aQwynZF/kqI2uMGDUsLJUPbzaideC8
         CSoGa8B/w4GjsQFMA7I6p3zdYxynLBi6W7c9xltXxow8QE8FbLLi+/2qTmcAEP+vrZ
         z7HtgLB/HwaCC4W3XXUSameRn9zzscy9yfx+VumY=
Date:   Tue, 8 Sep 2020 17:27:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     nikolay@cumulusnetworks.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org, josh@joshtriplett.org,
        peterz@infradead.org, christian.brauner@ubuntu.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au, roopa@nvidia.com
Subject: Re: [PATCH net-next] rcu: prevent RCU_LOCKDEP_WARN() from
 swallowing the condition
Message-ID: <20200908172751.4da35d60@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
References: <20200908090049.7e528e7f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200908173624.160024-1-kuba@kernel.org>
        <5ABC15D5-3709-4CA4-A747-6A7812BB12DD@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 08 Sep 2020 21:15:56 +0300 nikolay@cumulusnetworks.com wrote:
> Ah, you want to solve it for all. :) 
> Looks and sounds good to me, 
> Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Actually, I give up, lockdep_is_held() is not defined without
CONFIG_LOCKDEP, let's just go with your patch..
