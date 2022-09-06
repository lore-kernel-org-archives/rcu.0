Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D960C38145
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 17:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiIFRRh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 13:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237758AbiIFRRQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 13:17:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A8895694;
        Tue,  6 Sep 2022 10:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BAC7615C1;
        Tue,  6 Sep 2022 17:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C096AC433D7;
        Tue,  6 Sep 2022 17:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662483920;
        bh=pkC2ANF3tna1pzIjDrSAqSZoO9hFwZIzhtSAi9gowNk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PjAMYIYcPZWbcgvRkmd+ptsJC8tLyiy+WgXoZvqzf6QiX5NOl0P/E3uzQHDU1njIg
         MCpsFLTdbWORt6N0JqSnVFSrH5YJ9UAPUYuD5y9U6tNQ4CT6fxSfL/WYNEcOzvCMZr
         DCQ7CIQxD3HxjV/dQZPIbjvHq8jtZo94pxUrl3J2KFqi9zwK9KbuB3Vu9pSRM3DQZu
         Lo9RIICjydeOl68HUSgSroRfAWBnvXEX9F956ffWJF7/RF6CYF6swGh2uGXeyaSP1n
         wO0AMwFQ2Kj2AfTVtFYG+I59ov/6LOBFPiljXiBsJ/+monShyBpUurxEoCFnRKoDmW
         f8z/sR8plnWcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B99A85C0834; Tue,  6 Sep 2022 10:05:01 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:05:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220906170501.GX4315@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <67122ae3-d69e-438c-18fc-a8de6e40201e@joelfernandes.org>
 <20220905125949.GA173859@lothringen>
 <d82fec15-af9a-6ff6-69dd-a315cdca9892@joelfernandes.org>
 <20220906085512.GI4315@paulmck-ThinkPad-P17-Gen-1>
 <11d8b17a-1a82-148d-6da9-5e624b8e5942@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11d8b17a-1a82-148d-6da9-5e624b8e5942@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 06, 2022 at 12:16:19PM -0400, Joel Fernandes wrote:
> On 9/6/2022 4:55 AM, Paul E. McKenney wrote:
> > On Mon, Sep 05, 2022 at 04:32:26PM -0400, Joel Fernandes wrote:
> >>
> >>
> >> On 9/5/2022 8:59 AM, Frederic Weisbecker wrote:
> >>> I'd rather see an updated patch (not the whole patchset but just this one) rather
> >>> than deltas, just to make sure I'm not missing something in the whole picture.
> >>>
> >>> Thanks.
> >>
> >> There is also the previous patch which needs a fix up you suggested.
> >>
> >> I will reply to individual patches with in-line patch (for you), as well as
> >> refreshing whole series since it might be easier for Paul to apply them together.
> > 
> > To say nothing of the greater probability that the result will match
> > your intent.  ;-)
> 
> It is shaping up well ;-)

Very good, looking forward to the next round!

							Thanx, Paul
