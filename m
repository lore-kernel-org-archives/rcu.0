Return-Path: <SRS0=gdpO=5Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C93AC43331
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 16:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7442137B
	for <rcu@archiver.kernel.org>; Tue, 31 Mar 2020 16:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY5aB2IZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgCaQM1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:12:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41908 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaQM1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Mar 2020 12:12:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so22603600lji.8;
        Tue, 31 Mar 2020 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3kJ5mm1YOrHmUQGCcnHVGzEU+zZ+MYIie0xvbmsLdR0=;
        b=EY5aB2IZm5Vpo9RHwThnoY0oR6GY+XljzuA5498+JAIHFQRfhJbg5cRDPuto21J3LF
         Wr02golnyTUCEEmXtYJ0c1JAup4OqmCErYQ3BZXUc3gkmEdKbO2MqqkL2A4whX1OjSIv
         rCqCbcHMkvBZ4hWVJkwy47HuSol36XtdDMYQBV+PDFQRtAvLHoVr/aqH1EH2JbCY9ZxX
         JAvRuuIAfP8Vzd+9WMlEgO5EtwNLJ7E7Mb14o14ldatIIJIlrwnVlUQhHMSH41aXtnPI
         EpmKilYbHeAHoUd3PJs5n8v8RMSIeGnpb8MWHaBDqtyFIZRa/oAqv+vC/odykHajiOou
         73JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3kJ5mm1YOrHmUQGCcnHVGzEU+zZ+MYIie0xvbmsLdR0=;
        b=YUJfniK/WngbYgxXuZknlv/UuSNHmn3geqQCMOTJXxWRhFQrOhoRIy3dffOWv3/TTF
         NUBB+1skh6yLnYfgnFEi/9MATF+Mg4iyHy/IWR4/Z5+3bbUf1PfJ74ast9irlqwCqnF5
         Begj9J85lrGcwWLVq8kLIcSaCdIgro9x1IaS3daZ86OJWjCyf9GMfrDHesPC8IVYyYm9
         M7AHRboQZmerQvh2rJYtOWn0yct2JRUL1HL3C5sD3JZU07uiKt/OyctXwJcuZMc0NwY8
         z0VkKh/XW0j6tCSldXyTcv1IAvuNEKT2YLd5xO3S/N6cL4O3OnbWcV34KzhEfFtKAHSK
         jSqQ==
X-Gm-Message-State: AGi0Pua10gAJuKlc3g03b4LRNO0uVAx6dA6K7PtcVWb8ML33xsqSD93I
        mnLauY4ab8o3z9mmj6/+u6pt06Dj36k=
X-Google-Smtp-Source: APiQypLqQdmr1GaacubVbtq0EUXJknLP9Tdtt/Flex7ktt0z0TmEV9YaZnHo/L3/sJ4CixEb2npaxw==
X-Received: by 2002:a2e:89d2:: with SMTP id c18mr9341456ljk.29.1585671144929;
        Tue, 31 Mar 2020 09:12:24 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h20sm2634010lji.103.2020.03.31.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 09:12:22 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 31 Mar 2020 18:12:15 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331161215.GA27676@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331153450.GM30449@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> 
> __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> memory reserves regarless of the sleeping status.
> 
Michal, just one question here regarding proposed flags. Can we also
tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
times in order to increase the chance of being success.

Thanks!

--
Vlad Rezki
