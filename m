Return-Path: <SRS0=BzNy=Z2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB24C2BD09
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 15:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1333320863
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="u6pokYYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfLDPkB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:40:01 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40446 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbfLDPkB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Dec 2019 10:40:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id s35so3143101pjb.7
        for <rcu@vger.kernel.org>; Wed, 04 Dec 2019 07:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yf0/AyAbsCQScuwSh0FkTQfwVgWv8tTjAbyxzK0zN18=;
        b=u6pokYYSDBN0Rp74jlq4km9163s/bxCbqqwQgKLvwLLq7hphPCk1dgf878+h0qVVmM
         oV7Vue9ENHkWIJGRL7X1hXiu7FUUrbQYBpuBn1nz9Kjrd62+TdmBaVDPebDuggsEami0
         S0WXUL9OT1MT+WRt/jL2wKJFluZcb3sg62uSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yf0/AyAbsCQScuwSh0FkTQfwVgWv8tTjAbyxzK0zN18=;
        b=C+w4xckTnJ9PzXYJQpbBrdNb+WcXLwqH+41TY8FwV05chLvCf+ipUfrrdhFWeEckl9
         zzZsGYSrAKn53vMcoNa0bzJqWaxmskjQVD9l+NDeUqkRqsChTCL+GwHe0FBw0HaEsMo8
         MyF/vcmbuWMQZUKhMTLt3vU6yN6c+H6Gs9COircjyxzIRVg9NH3xpPUZhs0MIgnbCjDP
         Rh9/lUniY/OeGTPaEGQ0cqwG6fMG5PCq7geLL2gW4/joePwxkZop1vCjPEumKrthYz96
         5KRq1/B9W4EPdkjbF/TALtFO84EwcQfU9D7+E6tYrxEaqV8DJACuFoXOAoMmbJxifbwj
         PfNg==
X-Gm-Message-State: APjAAAWql+fZaOBIDFhxdnyT7iA2/dClwkmMOaNjszcAjrM2Bg39pWGf
        ZDs0MjmTMA5p6R6VE+VhEVKbFA==
X-Google-Smtp-Source: APXvYqydWvp2jT88+hxu6Hv9v4Gi45t2Z6QCPGmLhAy/GxOqbXhW3/mndI4tvMOl+WYPILBjfEd8DQ==
X-Received: by 2002:a17:90a:9bc6:: with SMTP id b6mr3975479pjw.77.1575474000054;
        Wed, 04 Dec 2019 07:40:00 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u3sm7370858pjn.0.2019.12.04.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:39:59 -0800 (PST)
Date:   Wed, 4 Dec 2019 10:39:58 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] doc: listRCU: Add some more listRCU patterns in the
 kernel
Message-ID: <20191204153958.GA17404@google.com>
References: <20191203063941.6981-1-frextrite@gmail.com>
 <20191203064132.38d75348@lwn.net>
 <20191204082412.GA6959@workstation-kernel-dev>
 <20191204074833.44bcc079@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204074833.44bcc079@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 04, 2019 at 07:48:33AM -0700, Jonathan Corbet wrote:
> On Wed, 4 Dec 2019 13:54:12 +0530
> Amol Grover <frextrite@gmail.com> wrote:
> 
> > The cross-reference of the functions should be done automatically by sphinx
> > while generating HTML, right? But when compiled none of the functions were
> > cross-referenced hence "``" was added around the methods (and other symbols)
> > to distinguish them from normal text.

Amol, when I tried your patch -- some functions were cross-referenced. Some
were not. I don't think all were not cross referenced.

> 
> If there's nothing to cross-reference to (i.e. no kerneldoc comments)
> then the reference obviously won't be generated.  I would still ask that
> you leave out the literal markers; they will block linking to any docs
> added in the future, and they clutter up the text - the plain-text reading
> experience is important too.

Actually I had asked Amol privately to add the backticks. It appeared super
weird in my browser when some function calls were rendered monospace while
others weren't. Not all functions were successfully cross referenced for me.
May be it is my kernel version?

Amol, do as Jon said and send a v2. Then I will test your patch again.

thanks,

 - Joel

