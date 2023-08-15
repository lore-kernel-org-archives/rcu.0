Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275E4C001B0
	for <rcu@archiver.kernel.org>; Tue, 15 Aug 2023 02:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjHOCPQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 14 Aug 2023 22:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjHOCOn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 14 Aug 2023 22:14:43 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290771705
        for <rcu@vger.kernel.org>; Mon, 14 Aug 2023 19:14:41 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7914633a110so222324839f.0
        for <rcu@vger.kernel.org>; Mon, 14 Aug 2023 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692065680; x=1692670480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FzNNwtEMI1ctcbSu9gtaMLkg80FqmdR5EYXg9JIFtg=;
        b=xnZSPDZ8UDmDG+AiHYeSS1LeuPfpOuSrcndRPANwOUJt3OYtEODCYZp2Dxkk+OnxR8
         CoXsPNRHEdgPz+lffz1vP/CLx83pVu40X0XRmr++k9bhC55jgSZ0N3V8V/evxz/0Cn4f
         PSonUuTCx7For67KXJz5wGNDLmEsjPcf2eIlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692065680; x=1692670480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FzNNwtEMI1ctcbSu9gtaMLkg80FqmdR5EYXg9JIFtg=;
        b=NQ0zNd3U5XDwV4Bn8VGjc6EFkk0qnSkXMKitBztDG2LCi41/xngTupL+b5+ARGOrV2
         edpGD0+fhXedkK3sHCI74ivBmV0KjkPknSpHEew5XeEAUE7px1VFKMX6B38MpSKmko46
         b+sSTp2QLqbc5F3TZO6nA6gpm/T/ZL+1ZSmxgLq9airmgb1/Y7MgsFqqzr0013c70QaF
         G61fL0HYY03/lesoVgfYK6sHM6CLNxEcKdWzf+ytnTngb5bvDs3rlkMkkLDU92EDwkyG
         Z7uAep09873xEhPWBFqG3oxBQcuTFfP/rnJjox0TEgjMB9xjvedycMIh7SceWZJdtHuG
         5nlg==
X-Gm-Message-State: AOJu0YzT8YD91qRkMe5EiGEz44+RXORNJOr3eB6cFdREN8OkQeFoOT94
        9cDGheoaVeXDICYu4F3CtHr28g==
X-Google-Smtp-Source: AGHT+IE52mS+ksJwzniELvA2SQYzEX5vpVK4FQh05SwiLQS3U1AdMZf58YQohMNFkK+sPEIGfwwxrg==
X-Received: by 2002:a05:6602:2195:b0:783:572c:9caa with SMTP id b21-20020a056602219500b00783572c9caamr15332100iob.0.1692065680377;
        Mon, 14 Aug 2023 19:14:40 -0700 (PDT)
Received: from localhost (254.82.172.34.bc.googleusercontent.com. [34.172.82.254])
        by smtp.gmail.com with ESMTPSA id d24-20020a056602229800b0077a1d1029fcsm3666568iod.28.2023.08.14.19.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 19:14:39 -0700 (PDT)
Date:   Tue, 15 Aug 2023 02:14:39 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] rcutorture: Copy out ftrace into its own console file
Message-ID: <20230815021439.GA2320449@google.com>
References: <20230813203602.GA696907@google.com>
 <8f952ce7-2122-45a4-82a3-a4e4dcd85ff4@paulmck-laptop>
 <CAEXW_YSr2Pg8cw2zrYaoRn8DQgSzM=7DhsPeO8=MMdsA6tN0zg@mail.gmail.com>
 <5bc1a075-db78-4ecd-af06-77555f4184bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bc1a075-db78-4ecd-af06-77555f4184bc@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

On Mon, Aug 14, 2023 at 03:27:33PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 14, 2023 at 06:03:24PM -0400, Joel Fernandes wrote:
> > On Mon, Aug 14, 2023 at 5:27 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Aug 13, 2023 at 08:36:02PM +0000, Joel Fernandes (Google) wrote:
> > > > From: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > > Often times during debugging, it is difficult to jump to the ftrace dump
> > > > in the console log and treat it independent of the result of the log file.
> > > > Copy the contents of the buffers into its own file to make it easier to refer
> > > > to the ftrace dump. The original ftrace dump is still available in the
> > > > console log if it is desired to refer to it there.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Queued, thank you!  I did the usual wordsmithing, please see below.
> > >
> > > I also fixed up the indentation and spacing.  I don't know about you,
> > > but the initial format made that a bit hard for me to read.  ;-)
> > >
> > > If there are multiple ftrace dumps in a given console.log file, this
> > > will concatenate them.  Is that the intent?
> > 
> > How would you have multiple dumps, do you mean from subsequent
> > (re)boots? If so, yes I am OK with that. I usually look at the latest
> > boot attempt.
> 
> Fair, but how would you separate out the ftrace dump for the most
> recent kernel boot?  (Though please see below.)

It will print the same markers in console.log which can be used. I posted an
updated diff below.

> 
> > I was also thinking of us stopping boot loops. For example, if there
> > is a kernel issue and the system keeps rebooting, it will run forever
> > in the boot loop silently. It would be good for monitoring of
> > console.log and kill the test if the console.log is acting 'weird'.
> > Also it would be good if the console.log had a huge timestamp gap in
> > it like the TREE04 issue. Would such changes be good to make? I can
> > attempt something.
> 
> Boot loops can indeed be irritating.  So I created this commit:
> 
> 10f84c2cfb50 ("torture: Avoid torture-test reboot loops")
> 
> This passes -no-reboot to qemu, which causes qemu to just stop when
> it would otherwise reboot.  Much nicer!
> 
> The multiple-ftrace-dump issue could still appear should some torture
> test decide to turn tracing back on at some point, perhaps in response
> to a yet-as-unthought-of module parameter.
> 
> Should this ever be a problem, one approach would be to leave the
> beginning/end markers and/or number them.

Thanks for doing this! I'll add it to all my trees.

Also let us replace the diff with the below [3] to properly label potential
multiple dumps?  Example for a file like [1], it will extract as [2].

[1]:

foo
foo
Dumping ftrace buffer:
---------------------------------
blah
blah
---------------------------------
more
bar
baz
Dumping ftrace buffer:
---------------------------------
blah2
blah2
---------------------------------
bleh
bleh

[2]:

Ftrace dump 1:
blah
blah

Ftrace dump 2:
blah2
blah2

---8<-----------------------
[3]

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
old mode 100644
new mode 100755
index b8e2ea23cb3f..a5c74e508e41
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -331,3 +331,30 @@ specify_qemu_net () {
 		echo $1 -net none
 	fi
 }
+
+# Extract the ftrace output from the console log output
+# The ftrace output in the original logs look like:
+# Dumping ftrace buffer:
+# ---------------------------------
+# [...]
+# ---------------------------------
+extract_ftrace_from_console() {
+        awk '
+        /Dumping ftrace buffer:/ {
+        buffer_count++
+        print "Ftrace dump " buffer_count ":"
+        capture = 1
+        next
+    }
+    /---------------------------------/ {
+        if(capture == 1) {
+            capture = 2
+            next
+        } else if(capture == 2) {
+            capture = 0
+            print ""
+        }
+    }
+    capture == 2
+    ' "$1";
+}
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 9ab0f6bc172c..e3d2f69ec0fb 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -182,3 +182,10 @@ if ! test -s $file.diags
 then
 	rm -f $file.diags
 fi
+
+# Call extract_ftrace_from_console function, if the output is empty,
+# don't create $file.ftrace. Otherwise output the results to $file.ftrace
+extract_ftrace_from_console $file > $file.ftrace
+if [ ! -s $file.ftrace ]; then
+	rm -f $file.ftrace
+fi
-- 
2.41.0.694.ge786442a9b-goog

