Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A9217F3D
	for <rcu@vger.kernel.org>; Sat, 26 Oct 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729930055; cv=none; b=ISAZoAdjq6AQU2SD/DTR1RflI4rEMIR5nXkKCvNNQoWEuh/dFnHjaxfFdXBB3R4JYT3h+PQ8bBYAVfAjAsZ8bagg8DBnoRsQYj5mmiVVClffPAE9egTOXLgQBe4ytFAmDYKO/eTwtQ3gPHw4QrKZ/Ys5iQIoE/AS+HgjbsfHlfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729930055; c=relaxed/simple;
	bh=LTz/sIJvzihwAzHHYP+4UacNmOinWqq0h5yhEhwcDgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJa1HFc6y6F3nHvBIE5f0zQAT16Cpg148s7xu3k2K9rtIvN/jHVWkfqhif+S+GWlOoAZ5zAUUfbOPbEzqfHdzUosdDtdZCxNkmdfxoSS0Dh5CGUQUy+JTbWQFWqiaBWU1ZQQoSM8pil0610xR2CUexAxVETdOZqstAZEEDT7wD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBRRT3Mq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBRRT3Mq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43169902057so26272875e9.0
        for <rcu@vger.kernel.org>; Sat, 26 Oct 2024 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729930051; x=1730534851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFjqILgh/ixcGjdS+zu+1bIEIH5TbcFvGQCHG9Z/ums=;
        b=TBRRT3MqLaQcGXp43ZtRXGQVDryb4KGm4HHVhbF7sTZY0t8BatNm6EfdAiVzTL6XHO
         /dlCf1bgGac8MpMqLovS1MuOLJbOJkF+feFOlMjIxF1LX692NXqwg7d9nPI9n5D8NbEx
         yVMfws+lm26Zz9OkJ3oUJjVYti+iFXqPaGS1mYWe7KfREZz9bQq6dG2WW1Gz8N28/ZWr
         yT359nnTWlx3tNCFtyzZLmFvRvjUhJJvr+YjXbuiEUr2f9h7/nw2oTL9E3imv5USXnfr
         dz9EvrJIONFwnVr3lBUZs6rVuceNJxEdOu+vDI432ddEU4vypfCR4TjwUslVG/++mTco
         m6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729930051; x=1730534851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFjqILgh/ixcGjdS+zu+1bIEIH5TbcFvGQCHG9Z/ums=;
        b=pU1H/F1sfXJDDQlRspz745t5M3Xek4P+x/yteBPSW4HlK8hhKpIJfVa3GaaP5u0yj0
         Z/72of/S0Qv4yWm8GudXfzRZ1Tc/oLj3zGyv7wqDf0jWjROk8puaRm3JpaYMyegc8+Zd
         REYzTqToaDbDXssND2/pK1FCKDhGJ0PI9UR1aL85UdrF+wJM8O6uR7qTI+YelMBgs5l0
         ne3Eo0dwfi6RlTFc6Q99gkrJ2Rrx4yqzKiynKBNt2odn9VQhrFFJ7HaXHc11PwafecZm
         J01X7jjLbrRVWOR+zi7j6fRKcG5xCaIFlUD80IlDOW4iVpb6JN2Hf2S1JIYXEYDmgu/g
         Cx0Q==
X-Gm-Message-State: AOJu0YzxcVtZpYKh4/PD3z+QMmyHNY66eY8FVSNpKFI0M+9MM7NheQ4w
	RcspXYXzdt/VWZxeF/xCEGvgNyIajylBPajax/rccwfnNeZxZFR/KGhFSaqt0Pg=
X-Google-Smtp-Source: AGHT+IFm+tgTY5urpMBlTEhy/kq07Z1LLqKeg4rp62VKYHlLc0B7MXCytHHoB4s2EibwQ3ar424PNQ==
X-Received: by 2002:a05:600c:458b:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-4319ac9b917mr14964175e9.13.1729930051270;
        Sat, 26 Oct 2024 01:07:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573cedsm40931845e9.4.2024.10.26.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 01:07:30 -0700 (PDT)
Date: Sat, 26 Oct 2024 11:07:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org
Subject: Re: [bug report] refscale: Add srcu_read_lock_lite() support using
 "srcu-lite"
Message-ID: <5b5e9db9-5253-4600-acf4-8cc8a5825030@stanley.mountain>
References: <663547f8-3126-453d-8f9e-f9ce252d43c2@stanley.mountain>
 <08a3a25e-0c83-41c1-ba07-db3e2c9ccf19@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a3a25e-0c83-41c1-ba07-db3e2c9ccf19@paulmck-laptop>

On Fri, Oct 25, 2024 at 06:04:45PM -0700, Paul E. McKenney wrote:
> On Fri, Oct 25, 2024 at 09:58:05AM +0300, Dan Carpenter wrote:
> > Hello Paul E. McKenney,
> > 
> > Commit 1e07186d7377 ("refscale: Add srcu_read_lock_lite() support
> > using "srcu-lite"") from Oct 15, 2024 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	kernel/rcu/refscale.c:1151 ref_scale_init()
> > 	warn: inconsistent indenting
> > 
> > kernel/rcu/refscale.c
> >     1141         for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
> >     1142                 cur_ops = scale_ops[i]; if (strcmp(scale_type,
> >     1143                 cur_ops->name) == 0)
> >     1144                         break;
> >     1145         }
> >     1146         if (i == ARRAY_SIZE(scale_ops)) {
> >     1147                 pr_alert("rcu-scale: invalid scale type: \"%s\"\n",
> >     1148                 scale_type); pr_alert("rcu-scale types:"); for (i = 0;
> >     1149                 i < ARRAY_SIZE(scale_ops); i++)
> >     1150                         pr_cont(" %s", scale_ops[i]->name);
> > --> 1151                 pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
> >     1152                 goto unwind;
> > 
> > This looks like you pressed the wrong button in vim and it accidentally jumbled
> > the code?
> > 
> >     1153         }
> >     1154         if (cur_ops->init)
> >     1155                 if (!cur_ops->init()) {
> >     1156                         firsterr = -EUCLEAN;
> >     1157                         goto unwind;
> >     1158                 }
> 
> Excellent guess!!!  :-(
> 
> How about the following?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit a489ef720efa78763afa39fe88d09dbb4176a47d
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Fri Oct 25 17:55:29 2024 -0700
> 
>     refscale: Undo j/J vim mistake in ref_scale_init()
>     
>     This commit gives each of three statements a line of their own.
>     
>     Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> index 7770e202d1ea1..7e6472a86dba8 100644
> --- a/kernel/rcu/refscale.c
> +++ b/kernel/rcu/refscale.c
> @@ -1182,7 +1182,9 @@ ref_scale_init(void)
>  		scale_type); pr_alert("rcu-scale types:"); for (i = 0;
                                                           ^^^^^^^^^^^
This for statement is messed up still.  :(

regards,
dan carpenter

>  		i < ARRAY_SIZE(scale_ops); i++)
>  			pr_cont(" %s", scale_ops[i]->name);
> -		pr_cont("\n"); firsterr = -EINVAL; cur_ops = NULL;
> +		pr_cont("\n");
> +		firsterr = -EINVAL;
> +		cur_ops = NULL;
>  		goto unwind;
>  	}
>  	if (cur_ops->init)
