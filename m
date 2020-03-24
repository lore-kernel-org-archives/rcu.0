Return-Path: <SRS0=d/lD=5J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A2C4332B
	for <rcu@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F277208CA
	for <rcu@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585041089;
	bh=Avy0x5g3KFYTxiEK27WTW2qhxrVE1nNzLDUNkDbTE6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c0jkEwcXScpL/7W6wsGcwa/18SID8AB4W8x1bLucVIprvo7eXrp+wHtx150p/+NCQ
	 dMuRif19DhGY+sjNnZ00oa2wb7z1yCOqX9Ic5a1/GtftpifN0KMbPKtuxjWbgCeVI7
	 ZytOTB2etlBOrKQ1uUKwPr4xWAT4UWarFwnhFudM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCXJL2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42424 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbgCXJLY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so8210562wrx.9;
        Tue, 24 Mar 2020 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XU6XS71vZD5h367wTsAuXGp1pePjRbXlg3MdVLDgs/E=;
        b=Fk3DrakuZEPTZ7rNK9JW5lgHsO8nGSlYevrmzq89VsAzQvNxRdnT0/h5zqjglgmeRy
         HyOAxa9Aw8iqvZ7giDD0Lihv7NPTHQmbZEq0l0tzzsxIuzxThsW3wgA2kOsiN6/6WgTO
         VIZYmvygplNy5SZvfUAXsBxxNxddTzGpPkaVGPDoK/G+de+FFZUFw7XREWLykeI+Mm0y
         k5e6gvvbBmzXXfel5OJSkmUCvGM+HzFbcjJP9VW5afnUmzK9d9ztB0Y/hLDzjh/JiTUj
         pPvnk6i1kxBNg8D0DLWUUSDQqre+LyhZSWg8MAYfpmEOMpesttE/st8wwirqmMseKMVU
         +7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XU6XS71vZD5h367wTsAuXGp1pePjRbXlg3MdVLDgs/E=;
        b=WOma7CBsxvEpK54TSKWhR/AakB+KgdQga+eTv2Iy7btdqDQ52iJu9ivQMGUsvDAQM1
         F0s/f/malluoiELCzvdQIdk9PkO/7UjrfSeADbirC1iesg5pEc/ykPSMNNoRiLEoK9MX
         lBUglqAQuQGO+tslPymQ67kQKCKdENxKCrRiqq7QJt6sYtQTaSwYqdTT88Lf8dHtCMmK
         vV7RMU4VCx9YLig9gghOnZ5S1m+INlygY9VqT4Lg2dTIPdddW3C0y5vbCaPMtc2poq9L
         iuhbDi7ri95764K2KSOniqBR0ftEePdYo6YJOEdNPvYAXYGgIRTbm2D5Rds0Ov1BsMIL
         x3kQ==
X-Gm-Message-State: ANhLgQ0m3Z6FU8rAq1xfHTj5S+Fnujpon6uGWkWAPFkv05GetJwcsMKy
        VQDxhvlGy9ypHc6AxDN/J/I=
X-Google-Smtp-Source: ADFU+vslunnyHEgVmY63uRmcj5eC1ZlILCO4/vaylFhdr+LjZyYIcstghFw1QnXWPWvGdU8nnm7M5Q==
X-Received: by 2002:adf:bb06:: with SMTP id r6mr35981331wrg.324.1585041083187;
        Tue, 24 Mar 2020 02:11:23 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c18sm26318367wrx.5.2020.03.24.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 02:11:22 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:11:20 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        colin.king@canonical.com, edumazet@google.com, frextrite@gmail.com,
        jbi.octave@gmail.com, joel@joelfernandes.org,
        madhuparnabhowmik04@gmail.com, sjpark@amazon.de, urezki@gmail.com
Subject: Re: [GIT PULL v2 rcu/next] RCU commits for v5.7
Message-ID: <20200324091120.GB48322@gmail.com>
References: <20200312211047.GA6096@paulmck-ThinkPad-P72>
 <20200322145310.GA7379@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322145310.GA7379@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> As discussed off-list, my earlier RCU pull request contained a commit with
> KCSAN dependencies, which caused build failures in the absence of KCSAN.
> These dependencies went undetected due to a flaw in my testing process
> that erroneously included the KCSAN commits.  This revised pull request
> removes those dependencies by pushing them to the post-v5.7 of the
> -rcu tree.  Non-KCSAN builds are unaffected.
> 
> As before, this pull request contains the following changes:
> 
> 1.	Documentation updates.
> 
> 	https://lore.kernel.org/lkml/20200214233848.GA12744@paulmck-ThinkPad-P72
> 
> 2.	Miscellaneous fixes.
> 
> 	https://lore.kernel.org/lkml/20200214235536.GA13364@paulmck-ThinkPad-P72
> 
> 3.	Make kfree_rcu() use kfree_bulk() for added performance.
> 
> 	https://lore.kernel.org/lkml/20200215000031.GA14315@paulmck-ThinkPad-P72
> 
> 4.	Locking torture-test updates.
> 
> 	https://lore.kernel.org/lkml/20200215000312.GA14585@paulmck-ThinkPad-P72
> 
> 5.	Callback-overload handling updates.
> 
> 	https://lore.kernel.org/lkml/20200215001816.GA15284@paulmck-ThinkPad-P72
> 
> 6.	Tasks-RCU KCSAN and sparse updates.
> 
> 	https://lore.kernel.org/lkml/20200215002446.GA15663@paulmck-ThinkPad-P72
> 
> 7.	SRCU updates.
> 
> 	https://lore.kernel.org/lkml/20200215002907.GA15895@paulmck-ThinkPad-P72
> 
> 8.	Torture-test updates.
> 
> 	https://lore.kernel.org/lkml/20200215003634.GA16227@paulmck-ThinkPad-P72
> 
> All of these have been subjected to the kbuild test robot testing,
> will get -next testing in the next -next, and are available in the git
> repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo
> 
> for you to fetch changes up to aa93ec620be378cce1454286122915533ff8fa48:
> 
>   Merge branches 'doc.2020.02.27a', 'fixes.2020.03.21a', 'kfree_rcu.2020.02.20a', 'locktorture.2020.02.20a', 'ovld.2020.02.20a', 'rcu-tasks.2020.02.20a', 'srcu.2020.02.20a' and 'torture.2020.02.20a' into HEAD (2020-03-21 17:15:11 -0700)
> 
> There is a modest increase in code size of about 700 lines.  About 300
> of these added lines were documentation, almost 200 more from adding
> kfree_bulk() support to kfree_rcu(), about 150 from torture-test
> improvements, and about 80 lines from improved callback-overload handling.
> All in all, good value from this expansion.

>  34 files changed, 1015 insertions(+), 294 deletions(-)

Pulled, thanks a lot Paul!

	Ingo
