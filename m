Return-Path: <SRS0=QfF2=7R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB3AC433E0
	for <rcu@archiver.kernel.org>; Thu,  4 Jun 2020 13:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFAF206E6
	for <rcu@archiver.kernel.org>; Thu,  4 Jun 2020 13:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKPFfTyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFDNnE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgFDNnD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 4 Jun 2020 09:43:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5991C08C5C0;
        Thu,  4 Jun 2020 06:43:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so3621561lfd.7;
        Thu, 04 Jun 2020 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pD3DL1EaqqhfcWp/JmI04Moao7zjsJCQcgkS8UaxqlM=;
        b=MKPFfTyNBu5xL7UVO/owP88fZoQ+vKDXkLQNZsqxE0/VkuzbWZiZ+Ceyej+3Ql5fxD
         txySRAOTxRKovhF50vbUYe/Xh/IsfP/7AZNMEc9o98vTKJe4LpFau4//de0QUq46kFPA
         aHonJp59+xVtgS//Y0qZ5SLBzJVR+btTICuCihHpdPWhUjPuzgIdmR4cxUjANfqw3eo0
         frdGIX+YmRKYML2LAiAH0JQtpAhbdixw8Cylog63L9jzrF23xMBiqhuPbAJFrnh/Qign
         vbZ5jz69ZjJSlIJW9ee2HApvVygDUoF9K5HV7vPgYCHz9YctFyYpAOCpiuWiaSF8R+OB
         +z0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pD3DL1EaqqhfcWp/JmI04Moao7zjsJCQcgkS8UaxqlM=;
        b=L1xF47CGVQiOjtn/TOl/wqHvbZevTeLADCz/mv1PJBOTcaEMUCZy1bwZae1rksBMjq
         HgqfG/NXTexerZvFOli+KsPz5Lm5BJEu7aRVUFcfWbSXD3Xzmzed/F6WhjfDnnCmtzZl
         crJmPCp8Ckuc6i5pu5E2b4Ff961zXn48JQpuVsodoGdEam4DKK1r3WQKzDkD2BZ1VDab
         97CK7vx+NgKG2lxOrQRFyZwt7ldLKitLH/GdVzSAaY8hLO5RhCdQLGPZZtW750teZwWg
         bmPqNyScwlpxRouQQPVD8IcM0mrd3CYYnhptMTthXc8COvDJIvS4vUHg8ltNeAsxyEKp
         4Xkg==
X-Gm-Message-State: AOAM533hpnIxqo7ZJCn2JbIAqtMR4AV/3XgILwA7NmomXYWUsya51sYe
        DfFDdRNtggYygPc0X78+lZk=
X-Google-Smtp-Source: ABdhPJytsfVJ7LvUsWJ6dPyF1k3beQt090aEMwO18JA1CYO7E4vI2OP1jIn9j9oKioBeaEA7xAakLQ==
X-Received: by 2002:ac2:5094:: with SMTP id f20mr2669227lfm.128.1591278179989;
        Thu, 04 Jun 2020 06:42:59 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id s8sm58463ljh.101.2020.06.04.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:42:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 4 Jun 2020 15:42:55 +0200
To:     Peter Enderborg <peter.enderborg@sony.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Stop shrinker loop
Message-ID: <20200604134255.GA24897@pc636>
References: <20200604102320.15914-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604102320.15914-1-peter.enderborg@sony.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 04, 2020 at 12:23:20PM +0200, Peter Enderborg wrote:
> The count and scan can be separated in time. It is a fair chance
> that all work is already done when the scan starts. It
> then might retry. This is can be avoided with returning SHRINK_STOP.
> 
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c716eadc7617..8b36c6b2887d 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3310,7 +3310,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			break;
>  	}
>  
> -	return freed;
> +	return freed == 0 ? SHRINK_STOP : freed;
>  }
>  
The loop will be stopped anyway sooner or later, but sooner is better :)
To me that change makes sense.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
