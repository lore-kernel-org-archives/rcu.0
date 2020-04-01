Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DEDC2D0F4
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682442078B
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTj9rUoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbgDAMcg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:32:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33931 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbgDAMcf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 08:32:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id p10so25316540ljn.1;
        Wed, 01 Apr 2020 05:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8L1/PQnaYBXbzEXUweVQSVAcSQPDyAlUiX0T3JYuuFY=;
        b=WTj9rUoGT58FPH1IwytfIF8RhdaoHlpu/RcEVNmQlRH2NJFfn6hoxF+2xB1d56SnnK
         SkZwxfmiR21dCYC/Sy0hQbd5OKqPU+IUF9zvQc7vgtNIvWKf2sdBlX27FQf4V7qxpcZ3
         d3RiayaUKlnU4Mc3IsTfY4R3V3tBt2+eZO/2R1JF4DRFe1aoIGa/yjgShd1KHrB0yhLZ
         gGryc5zPaSm6VmCTI/+DxVzJLIRvIPtkhvMua38Ja2OCEWr9HRbdCjEC9fq+xL9iakwh
         g0JwFYpEPuZUxT4aukz2BGVcSXXjoqCUhK/pP5qmDKtjccjgX0+h6jFrJYTqNMR3YynL
         +PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8L1/PQnaYBXbzEXUweVQSVAcSQPDyAlUiX0T3JYuuFY=;
        b=Xk1agpHaHe9ZuVohmLsAVZBf70RHC0Nvt7sHDD3Tnc3Yg/MHb42n2lu7QjuG6WMmr6
         DCltfY5zhhWZnKJxmi/XZdDeHURITuCe5T/VgUye5Q1beob1y8YZ4KpRKjpfQhjtJY8h
         q0ozzEaShsQZ06phhb6Lt/SBeB/M+IBo27kWMwAzcV1XDYtMX4XNPktICvdkbXBAIjkf
         w/pMF1p+wlx1BLczPEB62YZ246Yo8SXiVUkRF/wJdZFFHq/yCiHbFjP22Aw5jNT95sou
         hylU2SXDSreKR1lQCLuUnrzFJttzwMmzqZJQ1wFEnlDGyPeYtLsZe2rsuU8Ur41XFt/6
         NJKg==
X-Gm-Message-State: AGi0PuZ/aw6XZRRXg85nCavXnwcUaP2Rd8zJEpbCKx8Go4wb+wnDWDq6
        eSXg2aGQgJceOvQUUAH50uw=
X-Google-Smtp-Source: APiQypJPwFtOAJ2kUBAdMVY1kqthd4AAiL4fiBBSlc6OWULAJhNSrhHxOjfin2SD/kjs0urj7hF1fw==
X-Received: by 2002:a05:651c:1a5:: with SMTP id c5mr13087568ljn.113.1585744353370;
        Wed, 01 Apr 2020 05:32:33 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id a10sm1531864lfg.33.2020.04.01.05.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 05:32:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Apr 2020 14:32:30 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <20200401123230.GB32593@pc636>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331161215.GA27676@pc636>
 <20200401070958.GB22681@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401070958.GB22681@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 01, 2020 at 09:09:58AM +0200, Michal Hocko wrote:
> On Tue 31-03-20 18:12:15, Uladzislau Rezki wrote:
> > > 
> > > __GFP_ATOMIC | __GFP_HIGH is the way to get an additional access to
> > > memory reserves regarless of the sleeping status.
> > > 
> > Michal, just one question here regarding proposed flags. Can we also
> > tight it with __GFP_RETRY_MAYFAIL flag? Means it also can repeat a few
> > times in order to increase the chance of being success.
> 
> yes, __GFP_RETRY_MAYFAIL is perfectly valid with __GFP_ATOMIC. Please
> note that __GFP_ATOMIC, despite its name, doesn't imply an atomic
> allocation which cannot sleep. Quite confusing, I know. A much better
> name would be __GFP_RESERVES or something like that.
> 
OK. Then we can use GFP_ATOMIC | __GFP_RETRY_MAYFAIL to try in more harder
way.

Thanks!

--
Vlad Rezki
