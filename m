Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35FBC4707A
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 17:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C57611AB
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 17:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhEURh3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 21 May 2021 13:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233220AbhEURh3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 21 May 2021 13:37:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEB0261168;
        Fri, 21 May 2021 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621618565;
        bh=4aOxbiHGvShE6QjDYszuUr7TvUl6/VFWQI8sBfUysUU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=hi/W261FoFNP/QGvNDUiE95mXNskFLc5lTf+X6+xBckoXCXTUbFgBWOs+mNSEimqc
         BECCpY4bBmHV9tLiHbfx+KXp4E63V22HCPy0T6uV/K2UYGY2ePy9x1kylXpk2K7muk
         yStUy+YvZw89WdmyeBt5bXCI1yJkcaypO2RAc9T9MUCIQDJni65alU1znT8iCKiMmU
         JzrsPKJO+ZpUWot7kc3/bMwwNuGag2n3kAsl71E/apkcFjZXbK2Tf3zylLniNoISFz
         kEt6RDV6MEVncFpP0DTRAtzEz8msJ1TNDFsQPC6LgjAhnSj57wx9rk6roxQkD3+d6i
         Jl97pgwyVSl7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 89EBE5C0164; Fri, 21 May 2021 10:36:05 -0700 (PDT)
Date:   Fri, 21 May 2021 10:36:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu] Documentation/RCU: Fix nested inline markup
Message-ID: <20210521173605.GA4441@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <e23acc77-8b10-493e-63fa-76150be325f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23acc77-8b10-493e-63fa-76150be325f9@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, May 21, 2021 at 11:16:04AM +0900, Akira Yokosawa wrote:
> To avoid the ``foo`` markup inside the `bar`__ hyperlink marker,
> use the "replace" directive [1].
> 
> This should restore the intended appearance of the link.
> 
> Tested with sphinx versions 1.7.9 and 2.4.4.
> 
> [1]: https://docutils.sourceforge.io/docs/ref/rst/directives.html#replace
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Queued, thank you!  Or if this should instead go via the Documentation
tree:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
> Hi Paul,
> 
> This fixes broken-looking cross reference in section
> "Publish/Subscribe Guarantee" at:
> 
> https://www.kernel.org/doc/html/latest/RCU/Design/Requirements/Requirements.html#publish-subscribe-guarantee
> 
> To-be-replaced macro string can be much shorter.
> I preserved the whole string considering the readability of .rst.

And completely agreed on keeping the .rst readable.

							Thanx, Paul

>         Thanks, Akira
> --
>  Documentation/RCU/Design/Requirements/Requirements.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 38a39476fc24..45278e2974c0 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -362,9 +362,8 @@ do_something_gp() uses rcu_dereference() to fetch from ``gp``:
>        12 }
>  
>  The rcu_dereference() uses volatile casts and (for DEC Alpha) memory
> -barriers in the Linux kernel. Should a `high-quality implementation of
> -C11 ``memory_order_consume``
> -[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
> +barriers in the Linux kernel. Should a |high-quality implementation of
> +C11 memory_order_consume [PDF]|_
>  ever appear, then rcu_dereference() could be implemented as a
>  ``memory_order_consume`` load. Regardless of the exact implementation, a
>  pointer fetched by rcu_dereference() may not be used outside of the
> @@ -374,6 +373,9 @@ element has been passed from RCU to some other synchronization
>  mechanism, most commonly locking or `reference
>  counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
>  
> +.. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
> +.. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
> +
>  In short, updaters use rcu_assign_pointer() and readers use
>  rcu_dereference(), and these two RCU API elements work together to
>  ensure that readers have a consistent view of newly added data elements.
> -- 
> 2.17.1
> 
