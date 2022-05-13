Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B7C433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 14:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380704AbiEMOyK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353025AbiEMOyJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 10:54:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFFB1ADA7
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:54:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu29so15055049lfb.0
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qga4K74lc3fgOCAZ6qKWiq1+38f04+nsXNsncvmCLA8=;
        b=eqT29WE6dCys+sUGaE0J6DAhLGmPDz+bGbpxVw2b/jdYZs6/VliyEJj9+n6fNp79UN
         JBMu0kcrXo+3ano2/oyMvIvKlw9IHewdcflb4ogZF2k5B+hYyen8z8UfxxvpeLvtWDLD
         Co9+EY7eIFPM9ArMdhhBm8QbAHiclBY+jdOw/+yqLGnu1FD0XiHCzny9Imjx3UbvL3/a
         h1Irnf0y0DSvIvad926gQ/gKyW2lnCdw7zuJ7LpcuAudYCGrDMFQbSblvSk14NsZKHlQ
         vAkQZe31N6+bUFJjbuzUXZjfVkcf3mAgvqQa8bRAvoCqzEs+nQ/gI8XEEA8WvuPpubuL
         tgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qga4K74lc3fgOCAZ6qKWiq1+38f04+nsXNsncvmCLA8=;
        b=5E80CublIQBbaKQIbeFa4MCrKJOrmX5Y6AC6GkAxliMcA9Fs5NV9F98E9+DLtgNCgw
         JIrsW45b+zvT8cKrXzCoQeKd/GPdBxBPN1Amfa57HroqWfnmPTQpb0zpzat4h5Cx94up
         dNCBDerc49sG0XnxmunS3qGvrPkk4i+t/6ie9M6P9W/ri1L08X41N0D9N0sGbM20zSfq
         kV6xn5pb11NrWjw8DGpw1pkV+FDnkB7HjRPTNnfSkbIOyJN9ZSa0YcAaYyWFbksciOyB
         uLQ1fKHWTYCGsGr7aAwdDzSih+wNdNwZMYEyxhgNfTDAoJrVWV1RxSMrdeYYhXc5wujF
         tK5A==
X-Gm-Message-State: AOAM531p4jyr8hEoCtcMgW5mEqLcs2/XhO45KkHBwV6chat5qOOJnxWB
        YVdtUOG1P7DwQbKT7XbarAs=
X-Google-Smtp-Source: ABdhPJw7+e/MkR+GoufVHiAkwBt7YhAaxFHcx1PFAcIOZbft1JepbGabHSWQcSI5K4mCmAjOgM2XHw==
X-Received: by 2002:ac2:5319:0:b0:471:fc6e:674f with SMTP id c25-20020ac25319000000b00471fc6e674fmr3612346lfh.493.1652453645339;
        Fri, 13 May 2022 07:54:05 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id h2-20020ac25962000000b0047255d21198sm401422lfp.199.2022.05.13.07.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:54:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 13 May 2022 16:54:02 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 13/14] rcu/kfree: Fix kfree_rcu_shrink_count() return
 value
Message-ID: <Yn5xCm1EfNPsN2Yg@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-14-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-14-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:41AM +0000, Joel Fernandes (Google) wrote:
> As per the comments in include/linux/shrinker.h, .count_objects callback
> should return the number of freeable items, but if there are no objects
> to free, SHRINK_EMPTY should be returned. The only time 0 is returned
> should be when we are unable to determine the number of objects, or the
> cache should be skipped for another reason.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3828ac3bf1c4..f191542cdf5e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3637,7 +3637,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  		atomic_set(&krcp->backoff_page_cache_fill, 1);
>  	}
>  
> -	return count;
> +	return count == 0 ? SHRINK_EMPTY : count;
>  }
>  
>  static unsigned long
> -- 
> 2.36.0.550.gb090851708-goog
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzisalu Rezki
