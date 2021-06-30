Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592AEC11F65
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 13:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4D56141C
	for <rcu@archiver.kernel.org>; Wed, 30 Jun 2021 13:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhF3Nl5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Jun 2021 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhF3Nlz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Jun 2021 09:41:55 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD51C061756;
        Wed, 30 Jun 2021 06:39:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h2so3335019edt.3;
        Wed, 30 Jun 2021 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P6YkXWwp9vzsor2WzBqGvKiFhq9S2OEkbMs5Ffp5U0c=;
        b=vL++g7o7YmRs8XitUOwJIzDiGn6veaBC3D9lNfNfguBEXdDw3ZdpCB5+EXafkHwP8X
         UPiGke0dOjabBq6pnrje2xsdHZzJGMYYrYyq6PWe6gR3fWrirgozYue4Gjicufil6d8j
         urbRsXzBi2mRAKv7yGxA9J7Qxcl/xY2nqTqwfiOE06HDJwE/4qzs1VOJfA0WsSjBMUQH
         b0QbJzhoBbcnco2wDesN6Di03zIVoi4tSAIS1IcVs6z8gxEU8sO10m3KfVAX+er379W8
         gYCvdz7gJA7TG7XA7rQ89yYnjMc3dOWuqEbHoAdCUjOOo/j8ABdP89FFf3bBE8XygP/3
         i54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=P6YkXWwp9vzsor2WzBqGvKiFhq9S2OEkbMs5Ffp5U0c=;
        b=EN2H5J90EHD23RXJqCcHNzar1STf6SQjijk0MoF4J4W4X2nDkPsCUvy9djwoamSPvH
         c4/Qsp/sAmLWdDWuoTqBW6gewVkOCIRWbiK2skgcxpecG7N1nYBq4QYjKw+lUgIscMoF
         UIVOWALgi8G8aXuObmViIozvTTtPOOgRQKKCHJ+rI14IBRdGb+Cbh7jGncC0eVcGkcRt
         6oEfTx9WQ2iL4tMMstYlFSeJbHH4q3ULzGF48uR4AnJBrGhzTt64ijo/PAySXfw3fmCK
         fUmnkqiE67TEyevE5GmdkgdI+oFQkImP4kYOaPlIb2c3kmTD/lrDKpuYh+88hgMAQZVn
         mQIw==
X-Gm-Message-State: AOAM530s/2iGbC43vL7/BkCaoBvsXNdVukzKOM4c4IWbqtMfX36zaO8X
        0VdFPst8SsV+SpvuELgH2ak=
X-Google-Smtp-Source: ABdhPJwShKYOHnI+BvV4r2uFKOPQ9hI/AnAALXcKb+vBMwWJ5n2ca3gflQw7JnyU+xVBLUnJqrxEiw==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr47535736edy.32.1625060364019;
        Wed, 30 Jun 2021 06:39:24 -0700 (PDT)
Received: from gmail.com (94-21-131-96.pool.digikabel.hu. [94.21.131.96])
        by smtp.gmail.com with ESMTPSA id ml22sm7755328ejb.71.2021.06.30.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 06:39:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 30 Jun 2021 15:39:21 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     eb@emlix.com, frederic@kernel.org, jbi.octave@gmail.com,
        maninder1.s@samsung.com, qiang.zhang@windriver.com,
        urezki@gmail.com, yury.norov@gmail.com, zhouzhouyi@gmail.com,
        mark.rutland@arm.com, elver@google.com, bjorn.topel@intel.com,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, kasan-dev@googlegroups.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU, LKMM, and KCSAN commits for v5.14
Message-ID: <YNx0CaT2ZTyuNYCK@gmail.com>
References: <20210609232926.GA1715440@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210609232926.GA1715440@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


* Paul E. McKenney <paulmck@kernel.org> wrote:

> Hello, Ingo!
> 
> This pull request contains changes for RCU, KCSAN, and LKMM.  You can
> pull the entire group using branch for-mingo.  Or, if you prefer, you
> can pull them separately, using for-mingo-rcu to pull the RCU changes,
> for-mingo-kcsan to pull the KCSAN changes, and for-mingo-lkmm to pull
> the LKMM changes.
> 
> The changes are as follows:
> 
> 1.	RCU changes (for-mingo-rcu):
> 
> 	a.	Bitmap support for "all" as alias for all bits, and with
> 		modifiers allowed, courtesy of Yury Norov.  This change
> 		means that "rcu_nocbs=all:1/2" would offload all the
> 		even-numbered CPUs regardless of the number of CPUs on
> 		the system.
> 		https://lore.kernel.org/lkml/20210511224115.GA2892092@paulmck-ThinkPad-P17-Gen-1
> 
> 	b.	Documentation updates.
> 		https://lore.kernel.org/lkml/20210511224402.GA2892361@paulmck-ThinkPad-P17-Gen-1
> 
> 	c.	Miscellaneous fixes.
> 		https://lore.kernel.org/lkml/20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1
> 
> 	d.	kvfree_rcu updates, courtesy of Uladzislau Rezki and Zhang Qiang.
> 		https://lore.kernel.org/lkml/20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1
> 
> 	e.	mm_dump_obj() updates, courtesy of Maninder Singh, acked
> 		by Vlastimil Babka.
> 		https://lore.kernel.org/lkml/20210511225744.GA2893615@paulmck-ThinkPad-P17-Gen-1
> 
> 	f.	RCU callback offloading updates, courtesy of Frederic
> 		Weisbecker and Ingo Molnar.  ;-)
> 		https://lore.kernel.org/lkml/20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1
> 
> 	g.	SRCU updates, courtesy of Frederic Weisbecker.
> 		https://lore.kernel.org/lkml/20210511230720.GA2894512@paulmck-ThinkPad-P17-Gen-1
> 
> 	h.	Tasks-RCU updates.
> 		https://lore.kernel.org/lkml/20210511230924.GA2894768@paulmck-ThinkPad-P17-Gen-1
> 
> 	i.	Torture-test updates.
> 		https://lore.kernel.org/lkml/20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1

Pulled into tip:core/rcu.

> 2.	Kernel concurrency sanitizer (KCSAN) updates from Marco Elver
> 	and Mark Rutland (for-mingo-kcsan).
> 	https://lore.kernel.org/lkml/20210511232324.GA2896130@paulmck-ThinkPad-P17-Gen-1

Pulled into tip:locking/urgent.

> 3.	Linux-kernel memory model (LKMM) updates courtesy of Bj�rn T�pel
> 	(for-mingo-lkmm).
> 	https://lore.kernel.org/lkml/20210305102823.415900-1-bjorn.topel@gmail.com

Pulled into tip:locking/urgent.

Thanks Paul, and sorry about the late response! Will get these to Linus 
ASAP if you don't beat me at it.

	Ingo
