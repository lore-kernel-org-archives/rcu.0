Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915FBC71153
	for <rcu@archiver.kernel.org>; Sun, 10 Sep 2023 19:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjIJTsd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Sep 2023 15:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIJTsd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Sep 2023 15:48:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E212D;
        Sun, 10 Sep 2023 12:48:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B41C433C8;
        Sun, 10 Sep 2023 19:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694375309;
        bh=9UuN74tLddb723fnyqCQwHi5BUisS2bk+DV2UkYk/Ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chTgpvbwfN7Y8RbuFnCymv7LXpfvmp9yYvRSVNjHGP+FszURQ20gd05OcjwMGhvbC
         l1RS5/6vHKU+e4l14VnYEy1R6voyOQCAIIg2MHWt+FPC9AT0JkUrYY1F9pMi7LhSEf
         SItw+Jnv60jb1Q3O+BFlCc94C6BtIwF68hDBvPGxSAJYuAQ7Z8vhctO2FEUeRdhS7l
         OAfFosPs99HFyC62R76IufsO5o7gAZLc2PJ+f6uvbBuaRU53rAWIpjZ4a245YXmG8Z
         19rpR0+kvcex/mzTPBLBI7tyTn2UnTmBysdEvsXh2xz6tzVKKqshVYTcDKlXd1RhCL
         1xd5xMFSou6Dw==
Date:   Sun, 10 Sep 2023 21:48:25 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 02/10] rcu: Rename jiffies_till_flush to
 jiffies_lazy_flush
Message-ID: <ZP4diUqkZqgSJl8m@localhost.localdomain>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-3-frederic@kernel.org>
 <CAEXW_YQ1tz4G3EwPZBx=ADVzjDiQCVPA-4GtqMpFxfRsx3oc9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ1tz4G3EwPZBx=ADVzjDiQCVPA-4GtqMpFxfRsx3oc9A@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Le Fri, Sep 08, 2023 at 09:07:42PM -0400, Joel Fernandes a écrit :
> While at it, could we replace jiffies_lazy_flush with
> rcu_get_jiffies_lazy_flush() in the below? That way all users are
> going through the API.
> 
> With that,
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,

Makes sense, will do, thanks!
