Return-Path: <SRS0=v0Re=DQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86225C433DF
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3572F22245
	for <rcu@archiver.kernel.org>; Fri,  9 Oct 2020 06:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602224833;
	bh=2sb9TYOtoeRSnzcdSFmdCsS04qnc7aWL9yqTp3VY5YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=olTUymvk9WDP7+e9CqyR/9zVqgii+4tx54oAbMCgxIZ8XilXGBJMt2LkHrmUDUjag
	 i+tGC6KeDD/pilHmRv8B9FEdcyGu3VgEq0TpexE25v6Ffo1xNx8F5huwdW0LGgG/wZ
	 qeSFpNLNOq/4tby7JgSBvEHVtsR+zMVjvZqbagrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJIG1M (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Oct 2020 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgJIG1M (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Oct 2020 02:27:12 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DFC0613D2;
        Thu,  8 Oct 2020 23:27:12 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g4so8238208edk.0;
        Thu, 08 Oct 2020 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/qQ6z62oBTKW8sKojWB9f9ePL7Gl12iSS1GwgVd2B0=;
        b=LR7kmnh447DFLvGR+uFs3HNOb7qge4PfVTxQJOLV8F0FOHG7bllbNw0USoUNvoJ6Mv
         Ep9BVLZ2Ohrp5nvLZ1359oWQXwBvWJ0IFbd5BovhBs/5zCRar5KiR4IwNSFvnGts+ZDI
         utyrct9M4euk7zc46x5R5XABtd2Scl4msh/fLROj0rKDzH2FfSxlElRvRhgu/Xy0ZHHe
         ukBkvsf6Ajy3HI2vn0cBwX4Me4DUb2Xhg+633mybUS7To7QDeJS0/CacuVXwamMr7yX2
         aRwb7rMDN42ZXZx0wixUZpi/BwLiyNoL6APPG2yYT+i0vrp1T40iz4sQynTuHeWni6lY
         KQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=B/qQ6z62oBTKW8sKojWB9f9ePL7Gl12iSS1GwgVd2B0=;
        b=VYnsn+hJGuHCKP7bj/mAbdBDoGs5Rjbc7IL0PKpTICPrtnioid5TQIJ8cU8THJnWJo
         I22QD467RUZb/d6Hp6IK2PEkF4WoQKBP4qGS+3Uvr+OcRb443pgPrlQsOeULe7z8CV5G
         QsfkDcZr/ovFKmXNcARpnz5O6IEGwB086QO0rNna2A+1yvYDnG5rsZPFKPuSN7HNUFqv
         u87l5NUZzEA6T6X1fzubfiYRVHDbV9lWWUfNu1byoO8dCxfbpConbeHamfkDpPTojw20
         HmMgihHLUS3ESYuOMLtlen9z3qvRDe5lnaylWoNzC8bLU1ih8NC+0KmuRmRitTDt3Qua
         SYug==
X-Gm-Message-State: AOAM533Uz0qZbCmjoXwlMHwt6MHWClFJV/8nLhKhzQGVohT12vFSMnom
        EEj9NwbWQ8m3uXJ7EuJs9q4=
X-Google-Smtp-Source: ABdhPJw9WgDp3Ai3otLAiK6NI6UlxvoFUgnb306b4BDI0sd0VlE8CxkPrWWiAlcyS1dVQP7kPPyB4g==
X-Received: by 2002:a50:a693:: with SMTP id e19mr13290081edc.333.1602224831030;
        Thu, 08 Oct 2020 23:27:11 -0700 (PDT)
Received: from gmail.com (563BAB65.dsl.pool.telekom.hu. [86.59.171.101])
        by smtp.gmail.com with ESMTPSA id q3sm5602036edt.1.2020.10.08.23.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 23:27:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 9 Oct 2020 08:27:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        colin.king@canonical.com, grandmaster@al2klimov.de,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com,
        neeraju@codeaurora.org, paul.gortmaker@windriver.com,
        qiang.zhang@windriver.com, rdunlap@infradead.org,
        tklauser@distanz.ch, weiyongjun1@huawei.com, kernel-team@fb.com
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.10
Message-ID: <20201009062708.GB9972@gmail.com>
References: <20200914174607.GA12722@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914174607.GA12722@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains the following changes:
> 
> 1.	Documentation updates.
> 
> 	https://lore.kernel.org/lkml/20200831175419.GA31013@paulmck-ThinkPad-P72
> 
> 2.	Miscellaneous fixes.
> 
> 	https://lore.kernel.org/lkml/20200831180050.GA32590@paulmck-ThinkPad-P72
> 
> 3.	Torture-test updates.
> 
> 	https://lore.kernel.org/lkml/20200831180348.GA416@paulmck-ThinkPad-P72
> 
> 4.	New smp_call_function() torture test.
> 
> 	https://lore.kernel.org/lkml/20200831180731.GA582@paulmck-ThinkPad-P72
> 
> 5.	Strict grace periods for KASAN.  The point of this series is to find
> 	RCU-usage bugs, so the corresponding new RCU_STRICT_GRACE_PERIOD
> 	Kconfig option depends on both DEBUG_KERNEL and RCU_EXPERT, and is
> 	further disabled by dfefault.  Finally, the help text includes
> 	a goodly list of scary caveats.
> 
> 	https://lore.kernel.org/lkml/20200831181101.GA950@paulmck-ThinkPad-P72
> 
> 6.	Debugging for smp_call_function().
> 
> 	https://lore.kernel.org/lkml/20200831181356.GA1224@paulmck-ThinkPad-P72

>  57 files changed, 1582 insertions(+), 421 deletions(-)

Pulled into tip:core/rcu, thanks a lot Paul!

	Ingo
