Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8528C433EF
	for <rcu@archiver.kernel.org>; Wed, 22 Jun 2022 22:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376739AbiFVW6j (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376760AbiFVW6i (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jun 2022 18:58:38 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D963EF08
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:58:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id h20so6492923ilj.13
        for <rcu@vger.kernel.org>; Wed, 22 Jun 2022 15:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2W8cT9+eQP/K3OUSNqcjrwuCQBrEUD6L/kph3gY7Hc=;
        b=O6fnv4Cy/i2qtk+aGdD62UymIG285EMWD2hCwVrCefUiTfvUsRYlcMEjKreYwTu3lZ
         +iq1QI+GIo2tKBd2guBzCADuALCeRGVy2rpDkfOdjeJC7D677/MibJXcZVX+28Lt02WF
         80Z8jfTk5AyIgUL6JFFK67L6Es9LFlcmAeFEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2W8cT9+eQP/K3OUSNqcjrwuCQBrEUD6L/kph3gY7Hc=;
        b=6ngr+E5i67SKcTf55LX6xg1uyKIv8F58BazFLjCN+Zj5fYDnqOgZjr+zpH0YdI63YX
         jc05Nk5gkUJmZbVwvvaVYq859eEQv9fx1aKemOlH4dNLADEiQuehoDLnkDsMjxZ9gqi8
         0uE7aypUpdYUHTWWRUs8GBTo8EVbvRSA32rH2n7gWppLEDKgChrDuBx3qimPTIaH7hvE
         TMrsNBMGeZImNthPNZcNXg1Ppio60L9Y/+xlAJLHcoUjmHwyF65dsPcVZgnh46muoRUa
         dW3OKv8cWspg5e+yIoJrMkb8bYghPnpWjQWZFJ7F9uNcJpmMSyCN/YzXg0qIe0eNQzDY
         bfxQ==
X-Gm-Message-State: AJIora942AwXKWUbtC0dZglQS+epDWZsH/E2+lkCdcEMHz/SgwdqxA1h
        keoBlDaSKoeRfggB/vWErJufE42I7/23cYHHcV/FUWEhYfRdzA==
X-Google-Smtp-Source: AGRyM1uTjEDV3Av4QdjU0tC4xCKF/aqqmjNl9hypJfT8/qlCycU0mufZSPFw49wVHjACPx9kjglUutCG8FIRJIoKGMw=
X-Received: by 2002:a05:6e02:1986:b0:2d4:dfae:edef with SMTP id
 g6-20020a056e02198600b002d4dfaeedefmr3326335ilf.280.1655938716831; Wed, 22
 Jun 2022 15:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220622225102.2112026-1-joel@joelfernandes.org> <20220622225102.2112026-2-joel@joelfernandes.org>
In-Reply-To: <20220622225102.2112026-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 22 Jun 2022 18:58:26 -0400
Message-ID: <CAEXW_YQaXGmwmFbfSPAEG9SpfuSy3muhWhTFeuxSY4OwUWeHdA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] context_tracking: Use arch_atomic_read() in
 __ct_state for KASAN
To:     rcu <rcu@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vineeth@bitbyteword.org,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Apologies, I accidentally picked this specific commit up in my recent
git format-patch which ended up sending it out. Totally unintended.

On Wed, Jun 22, 2022 at 6:51 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> Context tracking's __ct_state() function can be invoked from noinstr state
> where RCU is not watching.  This means that its use of atomic_read()
> causes KASAN to invoke the non-noinstr __kasan_check_read() function
> from the noinstr function __ct_state().  This is problematic because
> someone tracing the __kasan_check_read() function could get a nasty
> surprise because of RCU not watching.
>
> This commit therefore replaces the __ct_state() function's use of
> atomic_read() with arch_atomic_read(), which KASAN does not attempt to
> add instrumention to.
>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
>  include/linux/context_tracking_state.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
> index 0aecc07fb4f5..81c51e5f0314 100644
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -49,7 +49,7 @@ DECLARE_PER_CPU(struct context_tracking, context_tracking);
>
>  static __always_inline int __ct_state(void)
>  {
> -       return atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
> +       return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
>  }
>  #endif
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>
