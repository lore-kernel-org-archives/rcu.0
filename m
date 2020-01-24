Return-Path: <SRS0=Fsgb=3N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DDBC2D0CE
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1542071A
	for <rcu@archiver.kernel.org>; Fri, 24 Jan 2020 04:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4C/N7dZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbgAXEbS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:31:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40117 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbgAXEbS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 23 Jan 2020 23:31:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so352638pgt.7;
        Thu, 23 Jan 2020 20:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vAi/KPd03pktMu80W5NnBp6vIHB4ASH6MsDJKtQDurE=;
        b=k4C/N7dZe/TMOaRdLeDTeD3N4gbKJp9jO141k9so9NNn2FFEp7NwMRw9tg0nHF2VI+
         S33kGt1IYfl082YG0Db/7zTYSya3CFz8CZ4ja+UsPQPtZo4hE6YVVyegRV6yw2WlYceg
         I6Ju++iLcb822zTTfrIiR4V9wVDGhvU1mjB83VwRkn4o0wzsLnLidr3kYjO8GlzSIG+r
         0sDqBjV3kft3F4hzBXT6TbmU2AAZ5qeFCGTdNySs3fPQKMxTEU1KIVG90yNL1Dm5uPon
         jxxvhF7bq7Lm9xEDT82sjh0lfzTJp56M+td9dnKCRDUVJ77k/hPtuOqV8PIucdqCE5wT
         Ka/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vAi/KPd03pktMu80W5NnBp6vIHB4ASH6MsDJKtQDurE=;
        b=p48qSPNV7wS11S/xsylP3R9VbRmgK13MC/kr+ITeQ+aYhQiHHA846onQhNwUzWk6zb
         wBFuB8NqzdaV6is8n66mi5iBXjCdNo0gv2FdRU4bKF+TwbnZr/FN0Z6O45sMhJX1SrQW
         D2dqEfSqmQ1Tuqb/kSIonwn80uesKGQOWu1bMzUmU3safff9zDlH0zvpjEY8+XV2oUFB
         qnlo5UfIau31VL3XyxOmMnLFSTygfNZYt9YaObjtyMa3wfJaFgwDMg1qqzHev3G8r1l/
         3x9XZ6NvYPsNQuLwlJFL7gvfxmsZS4wu3ayN2HaoIVwmshr6Qm0XCXx9Bk0nac2xeOgp
         nqaA==
X-Gm-Message-State: APjAAAVZNsWEAkR3/+/TymljxwBy/YQkXNBzRpS4MBE3GvHhLz4HdQ/R
        FrlZwRI0wnNnmFIJhLHFhw==
X-Google-Smtp-Source: APXvYqwIE6tTVfRLqcQR3euqy9sQFs/bkaoB4uaYCS+t/A3tlB9kn9l0qF1C84AXee8W9GbZZlfwLQ==
X-Received: by 2002:a63:2fc4:: with SMTP id v187mr1929780pgv.55.1579840277621;
        Thu, 23 Jan 2020 20:31:17 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee5:e37b:72:f3a9:f673:9aea])
        by smtp.gmail.com with ESMTPSA id h6sm4271929pfo.175.2020.01.23.20.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 20:31:17 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Fri, 24 Jan 2020 10:01:10 +0530
To:     Jessica Yu <jeyu@kernel.org>
Cc:     madhuparnabhowmik10@gmail.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] module.h: Annotate mod_kallsyms with __rcu
Message-ID: <20200124043110.GD23699@madhuparna-HP-Notebook>
References: <20200122170447.20539-1-madhuparnabhowmik10@gmail.com>
 <20200123172257.GA14784@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123172257.GA14784@linux-8ccs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 23, 2020 at 06:22:58PM +0100, Jessica Yu wrote:
> +++ madhuparnabhowmik10@gmail.com [22/01/20 22:34 +0530]:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch fixes the following sparse errors:
> > 
> > kernel/module.c:3623:9: error: incompatible types in comparison expression
> > kernel/module.c:4060:41: error: incompatible types in comparison expression
> > kernel/module.c:4203:28: error: incompatible types in comparison expression
> > kernel/module.c:4225:41: error: incompatible types in comparison expression
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Hi Madhuparna,
> 
> Thanks, I can confirm this patch fixes the sparse warnings. I've
> applied it to modules-next.
>
Thank you Jessica.

Regards,
Madhuparna

> Jessica
> 
> > ---
> > include/linux/module.h | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index bd165ba68617..dfdc8863e26a 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -429,7 +429,7 @@ struct module {
> > 
> > #ifdef CONFIG_KALLSYMS
> > 	/* Protected by RCU and/or module_mutex: use rcu_dereference() */
> > -	struct mod_kallsyms *kallsyms;
> > +	struct mod_kallsyms __rcu *kallsyms;
> > 	struct mod_kallsyms core_kallsyms;
> > 
> > 	/* Section attributes */
> > -- 
> > 2.17.1
> > 
