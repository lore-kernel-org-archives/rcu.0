Return-Path: <SRS0=J74S=TR=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77868C04AB4
	for <rcu@archiver.kernel.org>; Fri, 17 May 2019 10:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496F82087E
	for <rcu@archiver.kernel.org>; Fri, 17 May 2019 10:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y/eaNLUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfEQKvQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 May 2019 06:51:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbfEQKvP (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 May 2019 06:51:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so6303169wmj.1
        for <rcu@vger.kernel.org>; Fri, 17 May 2019 03:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I9rj8wX+8J0bujnI+u0p0sO0A094wMEogFOiqKUHZlk=;
        b=y/eaNLUqsYgwNrvXFu07+EliHgRZ3HaRERZdf/QAyvcumCWEAv48V/ie7wvBYsRVah
         S7AG+qg9dUafEBpfYqjE4+dt9fhRPDLIYc6x3a6aqLbePL9Gc7S8mWu7E2kwG6uzfOoR
         vbpE3priHNrfBaO3G5q6MN3EJ0UHGwtWSqim589t8K2TQpIOw7KtgI1ghYgVb388FGzQ
         lRvrD7pr6b3YPvmTiz59iYbTBFJ1POfp4hCiHBdQrr7WuyVSmTsOmanwxjUf9+ohJW3Z
         Wwu2GQMHgCwhMDMR2aiS3I8Zrxi5QNAkCa3qM5lNnOdzBJzwUhKtIwgbFZhtyGsJpYgQ
         T6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I9rj8wX+8J0bujnI+u0p0sO0A094wMEogFOiqKUHZlk=;
        b=jvbLL6hA9rUGwn5ctvvLNklUdILwNGHQxRVxLbCf/DyIvws4tGaURhI4F7EYEIAyEC
         O4zqcnldBM2aMjeGlkAJgG/dJPuAlundXqObO6CHOh+N3i6Uhy8Nao9Ouji21yvySkZo
         1roq7j5JkAKiHRKUBI9o/1emfs2XNCgfjURBSp+w66ABtdaHx0vaJBbwUE16lAawtNoC
         y0QYCIemINnlclrS59b3Ylh8ljZ74BsWrmaZgPwynEnEXHPMbbLQCOFgwEKQ201CnwT8
         3VgmYeP9yfssX83OSMK4+ndsnN+wkvkUEjVcAhtbC0+Dl5EXUnGjGc3vGhACZWc8AsIk
         06Kw==
X-Gm-Message-State: APjAAAUz1sc9EpqpMEa93K0SH9f0yrkr6o6BiVjK95h31NUoHciBDyth
        VFxYDW5hqkwg/goN6omY3TqlOg==
X-Google-Smtp-Source: APXvYqxOX/9KP887aat370qATZZE8CQNkvdb6o3ptCMW7T3KAmlQu5vX96Ik0eNWwdoqpTFHQnlP8A==
X-Received: by 2002:a1c:1d46:: with SMTP id d67mr21446385wmd.98.1558090273797;
        Fri, 17 May 2019 03:51:13 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id v12sm7462554wrw.23.2019.05.17.03.51.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 03:51:13 -0700 (PDT)
Date:   Fri, 17 May 2019 11:51:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rcu: Remove unused variable
Message-ID: <20190517105111.GW4319@dell>
References: <AM0PR07MB4417DD6F49126041FFC18864FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR07MB4417DD6F49126041FFC18864FD0B0@AM0PR07MB4417.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 17 May 2019, Philippe Mazenauer wrote:

> Variable 'rdp' is set but not used in synchronize_rcu_expidited(). The
> macro per_cpu_ptr() used to set the value of 'rdp' has no side effect.
> 
> ../kernel/rcu/tree_exp.h:768:19: warning: variable ‘rdp’ set but not used [-Wunused-but-set-variable]
>    struct rcu_data *rdp;
>                     ^~~
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>
> ---
>  kernel/rcu/tree_exp.h | 2 --
>  1 file changed, 2 deletions(-)

Looks reasonable:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
