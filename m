Return-Path: <SRS0=5yYX=6S=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0385CC47257
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6030206A4
	for <rcu@archiver.kernel.org>; Mon,  4 May 2020 12:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiOHvGeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEDMLA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 4 May 2020 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDMLA (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 4 May 2020 08:11:00 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DCEC061A0E;
        Mon,  4 May 2020 05:10:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id s9so4299352lfp.1;
        Mon, 04 May 2020 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6IzobKamdx6AWobQAsBJeBJj3dra3/Qhj8m4FejlIx4=;
        b=KiOHvGeIUeyZv5sImlMlL9o+C5/7T93X2NonnrLyrz7FedqeaH3CxNBZFeiABm9XVB
         vQTwvz/VUpMHZDaPnwFqVxC+BjLihteORKj2fyhUi4NezgMi72UJUVnO7kPLa1zvY8BQ
         sk+LB0U3klHmyK8MQ+dQs9vvvZ8y1dxLJvx/EBBl1t6H1hALhvp31uiUFV/J1OAGdvWp
         b7IcSJQGIFPiYq04X6Dl8UqmQuUzFaL+eNPZc85Kw39jzDs9qlZM7mlGjVGhufR0vPfZ
         JTr94RBLwqFqPpd4S8taE3QvFYCzuu1CFr5XgWsDcTISiw8dELWWLum8v1wBXY2YjukZ
         PlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6IzobKamdx6AWobQAsBJeBJj3dra3/Qhj8m4FejlIx4=;
        b=H3gtUtI6xSLMXqj87c5qI8bVmbpKB27k2MqJRWC/o9NYgrPvYf0fwNtSM0cgXAmBgm
         sF/Pp7JoL204Nf/ERagnyq6mjupgMrDJoPO+jBt+MpTVUo12DSIZWrnywwO8NE3eLr2M
         DSgiHXgn66KZHH97YgscbtJl/QKc5mNqVLagOBuVopyKAQFWc05ZNwsvVMN42IvvzW3b
         NvVMD1pTNJonZcx9RPM6hUmgKotNrwbT0C19StesTGotYkd3QKBt3I/eHhA3gWE4ICIU
         gUzxWK1U1UZQ/cNN8s9HQvdc+7IRIS8H20jPzLJrj5MUHpU76XI7nal/XRPnzvP+TzS3
         la5g==
X-Gm-Message-State: AGi0PuaZxxO+lrtMZqhtGj30vtOH/6zBhBKevWyV0PaFuQ961l0Hr5bk
        3gL0o/+n6Lvi55kbACFsV+Q=
X-Google-Smtp-Source: APiQypLO6HaXBufG+Iur+eLtCO6qgxjVTCFmu/o65Sm7lU1n6hbH0hvVL0cOXHKWWiUX/2c8K2qUPQ==
X-Received: by 2002:ac2:47fb:: with SMTP id b27mr10305946lfp.10.1588594258308;
        Mon, 04 May 2020 05:10:58 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id u24sm8061362ljl.28.2020.05.04.05.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:10:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 May 2020 14:10:55 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 08/24] rcu/tree: Use static initializer for krc.lock
Message-ID: <20200504121055.GA17457@pc636>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-9-urezki@gmail.com>
 <20200501211703.GC7560@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501211703.GC7560@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> >  
> > -	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
> > +	local_irq_save(*flags);	/* For safely calling this_cpu_ptr(). */
> 
> And here as well.  ;-)
> 
OK. For me it works either way. I can stick to "//" :)

--
Vlad Rezki
