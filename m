Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACBEC433FE
	for <rcu@archiver.kernel.org>; Fri,  7 Oct 2022 03:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiJGDU1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Oct 2022 23:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJGDTq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Oct 2022 23:19:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC1C90FC
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 20:18:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s21so2164675qtx.6
        for <rcu@vger.kernel.org>; Thu, 06 Oct 2022 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+hx0EU2RLAQ3o5tIiwSkGGZgPKc+L+R/ZKiXk87Fu3E=;
        b=AND1wOuZI0nTKAtCUDz87miknuAd6bmCob6xc924Y3rQRZPw/R5flKAN5tM7t7GcFl
         5oIJP6V7YnA+avfVqNaHGDOlk+9fU+CHIiuW5kRF2VxZ6iVaInT1KmjUBArIQBVepprN
         WT7ov/4iWc953AsSTrb2Apb6yGOH36Be9oK6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+hx0EU2RLAQ3o5tIiwSkGGZgPKc+L+R/ZKiXk87Fu3E=;
        b=fJk23snChqB35h6dhPL8Mm3Xm3keKMHsmeM6hMqFtejpLrMnVfRpFE3Iw4vkZFE6X8
         1H1cUnuvAH/6QfyszgLmA+emlmGdy1yh2OK72uCt4+MwHYCQB7hDkF5SQWE+MOU20n0T
         MfXlWJL0LI3DsksYWJmUJux31TQsuOOnUHum3ow4kjUy+8hoGxKTuc2F7ppBK3EuhVvC
         p8G1bV79J6oZkcjvS6K8qoipHJzlIzIf75jvpQFbx/LV3qfYjAK2asUz37fnJMzr8sD/
         P8heBu7/XsBdJbkRfmjwncrxklFYGVePPtWp4KOPDjt4y/4eAVvg0qBMGOdJ1R5RIbfJ
         11aQ==
X-Gm-Message-State: ACrzQf2R89DplQhpG1A95DWXPbylmuD3HVyj6LMWxbwaaD0SoclGpGTD
        hLq9bc1IRtRR+MAuY3VgrCbtDMiPNphZOQ==
X-Google-Smtp-Source: AMsMyM623f/v5fQ3Eu4rsyrUKGtIuGN8r83wpAvvv+pqkCkDXQjYBwYCmVaXDqjbZB6h5IYdX1z6iQ==
X-Received: by 2002:ac8:5f47:0:b0:394:7602:d9f0 with SMTP id y7-20020ac85f47000000b003947602d9f0mr2791965qta.683.1665112707253;
        Thu, 06 Oct 2022 20:18:27 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id u14-20020a37ab0e000000b006ced5d3f921sm832599qke.52.2022.10.06.20.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 20:18:26 -0700 (PDT)
Date:   Fri, 7 Oct 2022 03:18:26 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com
Subject: Re: [PATCH v7 10/11] scsi/scsi_error: Use call_rcu_flush() instead
 of call_rcu()
Message-ID: <Yz+agsJrvHg18FeC@google.com>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-11-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004024157.2470238-11-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Oct 04, 2022 at 02:41:56AM +0000, Joel Fernandes (Google) wrote:
> From: Uladzislau Rezki <urezki@gmail.com>
> 
> Slow boot time is seen on KVM running typical Linux distributions due to
> SCSI layer calling call_rcu(). Recent changes to save power may be
> causing this slowness. Using call_rcu_flush() fixes the issue and brings
> the boot time back to what it originally was. Convert it.
> 
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And I successfully setup Debian on KVM and verified that this fixes it, so
now I have a nice reproducible rig for my
'lazy-callback-doing-a-wakeup-detector' (I wrote half the detector thanks to
ideas from Steve, and will finish the other half tomorrow or so).

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  drivers/scsi/scsi_error.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 448748e3fba5..a56cfd612e3a 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>  	 * Ensure that all tasks observe the host state change before the
>  	 * host_failed change.
>  	 */
> -	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> +	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
>  }
>  
>  /**
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
