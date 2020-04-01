Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F876C43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349EC206F5
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585766657;
	bh=dFJJignhfyEupSLh7warErSBQQPjZWEj2LecqCbXml4=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=RIwmTeRpMpYOBg2H8NoGRe09QBFG0A2kzoCGcmD6vNVr1y51Q0WLpGJQlTFUcCLMn
	 BDYQlsYcDCNK2Wyob/gs4ENpy+rmHffFwg7vBhtermIDwgFtF+qIQ4WNqAx7ov7H7n
	 9wANkpej386I/vyK1bzKfHsffVvxcCgZ/hQ9TYZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgDASoQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgDASoQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 14:44:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B403206F5;
        Wed,  1 Apr 2020 18:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585766656;
        bh=dFJJignhfyEupSLh7warErSBQQPjZWEj2LecqCbXml4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=vXYSv1XizPlHbTVLgM3HbGo81YI/T+ZBDWUo4yyGlaehO4dDtOfa6AjWzItpZms+k
         HwMgiBCkrr/QklDVL91p2TqELtgLbuR3wPdjNOnfredyrJ2DOS/Pgu/yN98BVHVEH1
         ymuI2j/cDLgHGy6E+xYYMXGX7itdGtHFZSq6WxVk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DD75435226B3; Wed,  1 Apr 2020 11:44:15 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:44:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     urezki@gmail.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: What should we be doing to stress-test kfree_rcu()?
Message-ID: <20200401184415.GA7619@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

What should we be doing to stress-test kfree_rcu(), including its ability
to cope with OOM conditions?  Yes, rcuperf runs are nice, but they are not
currently doing much more than testing base functionality, performance,
and scalability.

							Thanx, Paul
