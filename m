Return-Path: <SRS0=yzHE=6P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0974FC35280
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC34208C3
	for <rcu@archiver.kernel.org>; Fri,  1 May 2020 21:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgEAVCG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 May 2020 17:02:06 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:47626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726045AbgEAVCG (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 1 May 2020 17:02:06 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2020 17:02:06 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id E6DDF1803190B
        for <rcu@vger.kernel.org>; Fri,  1 May 2020 20:52:50 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 9AC98181D3025;
        Fri,  1 May 2020 20:52:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: balls69_358bf361e1e3c
X-Filterd-Recvd-Size: 2389
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 20:52:47 +0000 (UTC)
Message-ID: <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
From:   Joe Perches <joe@perches.com>
To:     paulmck@kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Date:   Fri, 01 May 2020 13:52:46 -0700
In-Reply-To: <20200501190555.GB7560@paulmck-ThinkPad-P72>
References: <20200428205903.61704-1-urezki@gmail.com>
         <20200428205903.61704-4-urezki@gmail.com>
         <20200501190555.GB7560@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 2020-05-01 at 12:05 -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > with majority of commenting styles.
[]
> on /* */ style?
> 
> I am (slowly) moving RCU to "//" for those reasons.  ;-)

I hope c99 comment styles are more commonly used soon too.
checkpatch doesn't care.

Perhaps a change to coding-style.rst
---
 Documentation/process/coding-style.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index acb2f1b..fee647 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -565,6 +565,11 @@ comments is a little different.
 	 * but there is no initial almost-blank line.
 	 */
 
+.. code-block:: c
+
+	// Single line and inline comments may also use the c99 // style
+	// Block comments as well
+
 It's also important to comment data, whether they are basic types or derived
 types.  To this end, use just one data declaration per line (no commas for
 multiple data declarations).  This leaves you room for a small comment on each


