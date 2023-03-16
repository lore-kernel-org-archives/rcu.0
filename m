Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85EC6FD1D
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 00:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjCPAm6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 20:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCPAm5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 20:42:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B7AA24E
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 17:42:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32G0gRHD029391
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 20:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678927350; bh=CF/Yqvmt5HaUnn7sLCr7JAnwfpqcFftibSfzn6Ctny8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ae7SSdHemD//iTpR6K43rXsZZsTkud0Qmbc2qWXIghqgbLSQrEaUbUnAU/zlgEnAS
         qIpL1ewYOR5DijwGpikm8ggMzSwvHTwP3w5MGf91bpMK/6a8FunAu9o2LM3dyQHAWV
         6qhOxZCFUKecv9wMPeqaHmFXGoX9szcn09cpvosEoM843w1vbO7U/cdOMbaAOVdxNl
         9OgpYsqQBftreWRY0EtHPGnPfVFK5qkpdo6YppTN29hAyxp5iLvLSHonPEOhn3jIff
         cXeohzDatvXYq94gxvFPAxsXzQLtRJQUOkH6D9WeAEiSEVb0yJ2FOjEXsobVS7ci5x
         +WirciQsaQpuA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5ED8915C5830; Wed, 15 Mar 2023 20:42:27 -0400 (EDT)
Date:   Wed, 15 Mar 2023 20:42:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH 00/13] Rename k[v]free_rcu() single argument to
 k[v]free_rcu_mightsleep()
Message-ID: <20230316004227.GJ860405@mit.edu>
References: <20230201150815.409582-1-urezki@gmail.com>
 <20230315151415.2534e11c@gandalf.local.home>
 <e5a1815b-65b5-55ca-9773-ec04378d53c0@kernel.dk>
 <ZBIbloFMm5xRsjfn@pc636>
 <20230315153448.6914f85b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315153448.6914f85b@gandalf.local.home>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 15, 2023 at 03:34:48PM -0400, Steven Rostedt wrote:
> 
> Still, I will replace that code back to a kfree() and rcu_synchonize() than
> to let that other name get in.

That will have a performance hit relaive to kfree_rcu_mightsleep().
If that's OK with you, sure, you can do that.

Personally, I don't have a lot of problem with that name, which is why
I ack'ed the change for ext4.

						- Ted
