Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E7BEE49A3
	for <rcu@archiver.kernel.org>; Tue, 22 Aug 2023 15:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjHVPeU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbjHVPeT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 22 Aug 2023 11:34:19 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48207CD1
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 08:34:18 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-790970a8706so166362739f.2
        for <rcu@vger.kernel.org>; Tue, 22 Aug 2023 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692718457; x=1693323257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23HZEtSy74oKRHG4dRJMMnNxq2Nhz1/Vw/8CyykmCFA=;
        b=sy4v8ZilSundFmjh1wetcR8Cq484nYree/rTTCQXHX1HbVxrtmaDT+XSjMzjOsx7Ip
         03VhBqHfzRlt7wI8RITAWh3v2kxBml8XLfjbBkObFoqrUSaux5+qwJ26bM2YiO54yiFu
         vbj51a8T39bvpCTKbhZOI34cKH/I1j2PkfeEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718457; x=1693323257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23HZEtSy74oKRHG4dRJMMnNxq2Nhz1/Vw/8CyykmCFA=;
        b=I587IPs7E4wOexBLEWdSigyseKjPxkh7ATT2XAeqj5KlWFlMMWqeAZEXYkOYVucTkD
         I3HuOFMVBgs2TiVuVuuEDNvUWVPSOEiv1/0Py1KyETI8HfhRcbw6PhGcZ2zD820ZwXoC
         AwWxc6OxrWh7q9Rbhk/x73xiCSFmjMQS5tiAxSO+s8h+0NTRlVPuVXd+577E25sZGQof
         pJC3pNlxqafCZ1ee+GHFy5M7GS5TzR5iJc+EKT2rrCkRJ5tXrsu81EfFzQsbsAhCePU0
         6iyyDEh7cfDBupZ4POHIx1a99NNVDT7X8z1zDHWWNAHn8a6u1oHxpgur3KdhX+qkW9q4
         ld8w==
X-Gm-Message-State: AOJu0YxonZY+tcZoF7afpvHYErndOjEXD86mKxPIm5NeJPOxHcA4lrNz
        KbRtYKqBFLflxk6YXJBM319o5g==
X-Google-Smtp-Source: AGHT+IHGD5ggcRJRfTk5XATu8k1Uz0pBZJzm3JpEKzEMirIhJduTlwj54ThHlo9nj2B2EDZdQpso8g==
X-Received: by 2002:a5d:8550:0:b0:783:6272:afbb with SMTP id b16-20020a5d8550000000b007836272afbbmr63912ios.9.1692718457609;
        Tue, 22 Aug 2023 08:34:17 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id g4-20020a02c544000000b0042b3ad1656bsm3163204jaj.45.2023.08.22.08.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:34:16 -0700 (PDT)
Date:   Tue, 22 Aug 2023 15:34:16 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        chenhuacai@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V3] rcu: Update jiffies locally in rcu_cpu_stall_reset()
Message-ID: <20230822153416.GA72567@google.com>
References: <20230822040248.329442-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822040248.329442-1-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Aug 22, 2023 at 12:02:48PM +0800, Huacai Chen wrote:
> The KGDB initial breakpoint gets an rcu stall warning after commit
> a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in
> rcu_cpu_stall_reset()").
> 
> [   53.452051] rcu: INFO: rcu_preempt self-detected stall on CPU
[...]
> 
> [1] https://lore.kernel.org/rcu/20230814020045.51950-1-chenhuacai@loongson.cn/T/#t
> 
> Cc: stable@vger.kernel.org
> Fixes: a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall detection in rcu_cpu_stall_reset()")
> Reported-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Use NMI safe functions.
> V3: Add comments to explain why.
> 
>  kernel/rcu/tree_stall.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index b10b8349bb2a..e4e53113d062 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -150,11 +150,26 @@ static void panic_on_rcu_stall(void)
>   * rcu_cpu_stall_reset - restart stall-warning timeout for current grace period
>   *
>   * The caller must disable hard irqs.
> + *
> + * The jiffies updating may be delayed for a very long time due to tickless and
> + * irq disabled, especially in the KGDB case, so we need to add the delayed time
> + * (delta) to rcu_state.jiffies_stall.
> + *
> + * This function may be called in NMI context, so we cannot use ktime_get_ns()
> + * and ktime_get_coarse_ns(). Instead, we use their inaccurate but safe friends
> + * ktime_get_mono_fast_ns() and ktime_get_seconds() which will cause rcu_state.
> + * jiffies_stall to be a little large than expected (harmless and safer).
>   */
>  void rcu_cpu_stall_reset(void)
>  {
> +	u64 curr, last, delta;
> +
> +	curr = ktime_get_mono_fast_ns();
> +	last = ktime_get_seconds() * NSEC_PER_SEC;
> +	delta = nsecs_to_jiffies(curr - last);
> +
>  	WRITE_ONCE(rcu_state.jiffies_stall,
> -		   jiffies + rcu_jiffies_till_stall_check());
> +		   jiffies + delta + rcu_jiffies_till_stall_check());
>  }

I prefer the following diff on top of your patch to take advantage of UBSAN
detecting overflows.

If you take my diff, feel free to add:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---8<-----------------------

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5e9e4779bdf1..3398cf2d19c5 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -162,14 +162,15 @@ static void panic_on_rcu_stall(void)
  */
 void rcu_cpu_stall_reset(void)
 {
-	u64 curr, last, delta;
+	ktime_t last, delta_ns;
+	u64 delta_jiff;
 
-	curr = ktime_get_mono_fast_ns();
 	last = ktime_get_seconds() * NSEC_PER_SEC;
-	delta = nsecs_to_jiffies(curr - last);
+	delta_ns = ktime_sub(ktime_get_mono_fast_ns(), last);
+	delta_jiff = nsecs_to_jiffies(delta_ns);
 
 	WRITE_ONCE(rcu_state.jiffies_stall,
-		   jiffies + delta + rcu_jiffies_till_stall_check());
+		   jiffies + delta_jiff + rcu_jiffies_till_stall_check());
 }
 
 //////////////////////////////////////////////////////////////////////////////
