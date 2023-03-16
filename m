Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8C8C6FD1F
	for <rcu@archiver.kernel.org>; Thu, 16 Mar 2023 15:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjCPPSX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCPPSW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 11:18:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B9B9517
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 08:18:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i24so2060846qtm.6
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678979901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sTZi71W7uS0cwwOVrssYyJhaieKUx7HA3YH7kg22iWg=;
        b=G5MWWoFjX8wVVDLh02k8xeSq17tMezVMLXrakJuNUb73LG+XWQJlw7nTf8xuACnYNY
         +XXLqtEhDNFxvqNnpm8EDNPVTLRurg2DNS4ZW/4iu2qxhQhtGLofT0KmG1S5YBiDwT4R
         qKxa/YL1pmknx55aPGsjeoj/ULlIY5TUxtO7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678979901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTZi71W7uS0cwwOVrssYyJhaieKUx7HA3YH7kg22iWg=;
        b=MyOAqITbw5xp9enTCWSWtIEa1qNhEtQQPHZhYOZgeaicMP7DZIeP6uBLRflz7s3X8n
         PThfIvzb6gu5mO4iOig/zG6Z+W8YFHIaCjbcotzYFdN5TgEMGHxe0vmsQNjH1Ck/qTXf
         8r8xGT54yLPIgrNNjZC1c8jiX5T9PcddP4WGA4Uwkp+oo0MKqRDZ7u+6u79l6474ReF9
         oosgoRftO7vgx6bPESlkHt3qerzXqkpJYBG08MCT5RbRiaw4b/f76XNwXYPBL/9Vvz8w
         6AvEV3hc82GoARinXCMQCDYTXXXGqXn74kN3Emec339iETSzOa8yLc/zTzpSqYN8+2W/
         yCgA==
X-Gm-Message-State: AO0yUKVf7psunyaJwCJdik05ySehUrOUuALG49aDGWTzdUw2jf6ylVrd
        Z5VZQj3729SWoOD/iXLoLwd6EQ==
X-Google-Smtp-Source: AK7set9/nih+ai6mH+Z/lNZ6whQsRqf6IqmBjbgUKssX1LycRWgBcHithG4viTVGXudas9QnRWb5RA==
X-Received: by 2002:ac8:7c4f:0:b0:3d3:da2a:194e with SMTP id o15-20020ac87c4f000000b003d3da2a194emr7065833qtv.8.1678979900808;
        Thu, 16 Mar 2023 08:18:20 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id b10-20020ac8678a000000b003b9b48cdbe8sm5860986qtp.58.2023.03.16.08.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 08:18:20 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:18:20 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] docs: RCU: typo fix
Message-ID: <20230316151820.GA373925@google.com>
References: <20230316070936.733-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316070936.733-1-adrianhuang0701@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 16, 2023 at 03:09:36PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> It should be "Please note that ..." instead of "Please not that ...".
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
>  Documentation/RCU/checklist.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
> index cc361fb01ed4..bd3c58c44bef 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
>  	can serve as rcu_read_lock_sched(), but is less readable and
>  	prevents lockdep from detecting locking issues.
>  
> -	Please not that you *cannot* rely on code known to be built
> +	Please note that you *cannot* rely on code known to be built
>  	only in non-preemptible kernels.  Such code can and will break,
>  	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
>  
> -- 
> 2.34.1
> 
