Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938EFC3DA78
	for <rcu@archiver.kernel.org>; Tue, 17 Jan 2023 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAQVIT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjAQVGd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Jan 2023 16:06:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76390864;
        Tue, 17 Jan 2023 11:32:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95E75B81A19;
        Tue, 17 Jan 2023 19:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D85DC433D2;
        Tue, 17 Jan 2023 19:32:26 +0000 (UTC)
Date:   Tue, 17 Jan 2023 14:32:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu: Track laziness during boot and
 suspend
Message-ID: <20230117143224.6fbf7da8@gandalf.local.home>
In-Reply-To: <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
References: <20230112005223.2329802-1-joel@joelfernandes.org>
        <20230115162504.08ef72b0@rorschach.local.home>
        <CAEXW_YSNurO-hK+q2amP6wa96jr0KkZ_ggF+5x_sTHESC9vpNw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 15 Jan 2023 16:34:58 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> > > +EXPORT_SYMBOL_GPL(rcu_async_hurry);
> > >  
> >
> > Where do you plan on calling these externally, as they are being
> > marked exported?
> >
> > If you allow random drivers to enable this, I can see something
> > enabling it and hitting an error path that causes it to never disable
> > it.  
> 
> You mean, just like rcu_expedite_gp() ?
> 
> > I wouldn't have EXPORT_SYMBOL_GPL() unless you really know that it is
> > needed externally.  
> 
> At the moment it is not called externally but in the future, it could
> be from rcutorture. If you see rcu_expedite_gp(), that is exported
> too. I was just modeling it around that API.

The reason for the export should have been mentioned in the change log if
the patch is not obvious to why it is being exported.

Thanks,

-- Steve
